class FeedbacksController < ApplicationController
  require "csv"
  before_action :set_course, only: [ :new, :create ]
  before_action :set_trainee, only: [ :new, :create ]
  before_action :set_sub_topic, only: [ :create ]

  def index
    @feedbacks = Feedback.where(course_id: params[:course_id], trainee_id: current_user.id)
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = @course.feedbacks.build(
      feedback_params.merge(
        mentor: current_user,
        trainee: @trainee,
        subtopic: @subtopic
      )
    )
    if @feedback.save
      redirect_to course_users_path(@course), notice: "Feedback was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def bi_weekly
    @user = User.find_by(id: params[:user_id])
  end

  def create_bi_weekly
    @user = User.find_by(id: params[:user_id])

    unless @user
      flash[:alert] = "User not found"
      redirect_to portal_users_path
      return
    end

    feedback_data = {
      "learningCapability" => params[:learningCapability],
      "taskPerformance" => params[:taskPerformance],
      "behavior" => params[:behavior],
      "communication" => params[:communication],
      "overall" => params[:overall],
      "comments" => params[:comments]
    }
    rating  = get_rating
    feedback = Feedback.create(feedback_data: feedback_data, trainee_id: @user.id, mentor_id: current_user.id, course_id: params[:course_id], rating: rating)
    if feedback.persisted?
      flash[:notice] = "Feedback submitted successfully"
      redirect_to portal_users_path
    else
      flash[:alert] = "Error submitting feedback"
      render "bi_weekly"
    end
  end

  def all_feedbacks
    @feedbacks = Feedback.where.not(feedback_data: nil).order(created_at: :desc)
  end

  def export_to_csv
    feedback_ids = params[:feedback_ids] || []
    feedbacks = Feedback.where(id: feedback_ids)

    respond_to do |format|
      format.csv do
        headers = [ "Name", "Learning Capability", "Task Performance", "Behavior", "Communication", "Overall", "Course", "Created At" ]
        csv_data = CSV.generate(headers: true) do |csv|
          csv << headers
          feedbacks.each do |feedback|
            csv << [
              feedback.trainee.name,
              feedback.feedback_data["learningCapability"],
              feedback.feedback_data["taskPerformance"],
              feedback.feedback_data["behavior"],
              feedback.feedback_data["communication"],
              feedback.feedback_data["overall"],
              feedback.course.name,
              feedback.created_at.strftime("%Y-%m-%d %H:%M:%S")
            ]
          end
        end

        send_data csv_data, filename: "feedbacks_#{Date.today}.csv"
      end
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_trainee
    @trainee = User.find_by(id: params[:user_id])
  end

  def set_sub_topic
    @subtopic = @course.subtopics.find_by(id: params[:feedback][:subtopic_id])
  end

  def feedback_params
    params.require(:feedback).permit(:rating, :detail)
  end

  def get_rating
    (params[:overall].to_i + params[:overall].to_i + params[:communication].to_i + params[:taskPerformance].to_i + params[:learningCapability].to_i)/12
  end
end
