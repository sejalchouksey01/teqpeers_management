class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_authorised, only: [:new, :create, :mark_attendance]

  def index
    @trainees = User.trainee
    render 'user_statuses' if params[:status] == "true"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  def mark_attendance
    params["attendance"].each do |data|
      user = User.find_by(id: data[0])
      if user.present?
        existing_attendance = Attendance.find_by(user_id: user.id, date: Date.today)
        if existing_attendance && existing_attendance.status != data[1]
          existing_attendance.update(status: data[1])
        end
        unless existing_attendance
          Attendance.create(user_id: user.id, status: data[1].to_i, date: Date.today)
        end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :address, :role, :email, :password)
  end
end
