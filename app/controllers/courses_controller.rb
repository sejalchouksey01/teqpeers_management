class CoursesController < ApplicationController
  def users
    @course = Course.find_by(id: params[:course_id])
    @course_trainee = @course.users
  end
end
