class FeedbacksController < ApplicationController
  before_action :set_course, only: [:new, :create]
  before_action :set_trainee, only: [:new, :create]
  before_action :set_sub_topic, only: [ :create]

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
      redirect_to course_users_path(@course), notice: 'Feedback was successfully created.'
    else
      render :new, status: :unprocessable_entity
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
