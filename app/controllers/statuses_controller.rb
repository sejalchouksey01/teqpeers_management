class StatusesController < ApplicationController
  before_action :is_authorised, only: :index
  def index
    @user = User.find(params[:user_id]) 
    @statuses = @user.statuses.order(date: :desc) 
  end

  def save_daily_status
    @status = current_user.statuses.build(status_params)
  
    if @status.save
      flash[:notice] = "Your daily status has been saved."
    else
      flash[:alert] = "There was an issue saving your status: #{@status.errors.full_messages.to_sentence}."
    end
  
    redirect_to dashboard_path
  end  

  private

  def status_params
    params.permit(:content, :date)
  end
end
