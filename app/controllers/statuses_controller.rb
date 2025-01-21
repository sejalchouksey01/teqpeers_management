class StatusesController < ApplicationController

  def index
    @user = User.find(params[:user_id]) 
    @statuses = @user.statuses.order(date: :desc) 
  end

  def save_daily_status
    @status = current_user.statuses.new(status_params)
    if @status.save
      redirect_to dashboard_path, notice: "Your daily status has been saved."
    else
      redirect_to dashboard_path, alert: "There was an issue saving your status."
    end
  end

  private

  def status_params
    params.permit(:content, :date)
  end
end
