class EnrollmentsController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    # Assuming `trainees` are users with a role of 'trainee'
    @trainees = User.trainee.where.not(id: @course.users.pluck(:id))
  end

  def create
    @course = Course.find(params[:course_id])
    @enrollment = Enrollment.new(user_id: params[:user_id], course_id: @course ) if @course.present?
    if @enrollment.save
      redirect_to new_course_enrollment_path(@course), notice: "#{user.name} has been enrolled in the course."
    end
  end
end
