class DashboardController < ApplicationController
  def index
    @courses = Course.all if current_user.mentor? || current_user.manager?
  end
end
