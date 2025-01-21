class FeedbacksController < ApplicationController
  before_action :set_course, only: [:new, :create]
  before_action :set_trainee, only: [:new, :create]
  before_action :set_sub_topic, only: [ :create]

  def index
    @feedbacks = Course.find_by(id: params[:course_id]).feedbacks.where(trainee_id: current_user.id)
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.course = @course
    @feedback.mentor = current_user
    @feedback.trainee = @trainee
    @feedback.subtopic = @subtopic
    if @feedback.save
      redirect_to course_users_path(@course), notice: 'Feedback was successfully created.'
    else
      render :new
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
end
