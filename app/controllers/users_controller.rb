class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_authorised

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
      redirect_to portal_users_path
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

  def portal_users
    @users = User.all
  end

  def destroy
    binding.pry
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to portal_users_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to portal_users_path
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :address, :role, :email, :password)
  end
end
