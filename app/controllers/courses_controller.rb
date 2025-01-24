class CoursesController < ApplicationController
  before_action :is_mentor
  before_action :set_course, only: [ :edit, :update, :destroy ]

  def users
    @course = Course.find_by(id: params[:course_id])
    @course_trainee = @course.users
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to dashboard_path, notice: "Course was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @course.destroy
      redirect_to dashboard_path, notice: "Course deleted successfully"
    else
      render "not"
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to course_subtopics_path(@course), notice: "Course was successfully updated."
    else
      render :edit
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :description)
  end

  def is_mentor
    render dashboard_path unless current_user.mentor?
  end

  def set_course
    @course = Course.find(params[:id])
  end
end
