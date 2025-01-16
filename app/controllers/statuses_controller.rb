class StatusesController < ApplicationController
  def save_daily_status
    # Assuming user is logged in and can submit their daily status
    binding.pry
    @status = current_user.statuses.new(status_params)
    if @status.save
      redirect_to dashboard_path, notice: "Your daily status has been saved."
    else
      redirect_to dashboard_path, alert: "There was an issue saving your status."
    end
  end

  private

  def status_params
    params.require(:status).permit(:content, :date)
  end
end
