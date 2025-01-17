class AttendancesController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @attendances = @user.attendances
  end
end
