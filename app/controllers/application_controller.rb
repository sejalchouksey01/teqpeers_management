class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  private

  def is_authorised
    render dashboard_path unless current_user.manager? || current_user.mentor?
  end
end
