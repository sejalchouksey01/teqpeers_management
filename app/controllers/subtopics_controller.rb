class SubtopicsController < ApplicationController
  before_action :set_course
  before_action :set_subtopic, only: [ :edit, :destroy, :update ]
  before_action :is_authorised, only: [ :new, :edit, :update, :create, :destroy ]

  def index
    @subtopics = @course.subtopics
  end

  def new
    @subtopic = @course.subtopics.build
  end

  def create
    @subtopic = @course.subtopics.build(subtopic_params)

    if @subtopic.save
      redirect_to course_subtopics_path(@course), notice: "Subtopic was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subtopic.update(subtopic_params)
      redirect_to course_subtopics_path(@subtopic.course), notice: "Subtopic was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @subtopic = @course.subtopics.find_by(id: params[:id])
    if @subtopic.destroy
      redirect_to course_subtopics_path(@course)
    end
  end

  private
  def set_course
    @course = Course.find_by(id: params[:course_id]) if params[:course_id]
  end

  def set_subtopic
    @subtopic = @course.subtopics.find_by(id: params[:id]) if params[:course_id]
  end

  def subtopic_params
    params.require(:subtopic).permit(:title, :description)
  end
end
