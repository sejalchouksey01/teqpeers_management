class FeedbacksController < ApplicationController
  def index
    @feedbacks = Course.find_by(id: params[:course_id]).feedbacks.where(user_received_id: current_user.id)
  end
end
