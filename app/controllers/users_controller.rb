class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @trainees = User.trainee
    render 'user_statuses' if params[:status] == "true"
  end

  def mark_attendance
    params["attendance"].each do |data|
      user = User.find_by(id: data[0])
      if user.present? && current_user.mentor?
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
end