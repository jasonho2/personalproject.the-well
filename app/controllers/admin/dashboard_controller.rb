module Admin
  class Admin::DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin

    def index
      @posts = Post.all
      @users = User.all
    end

    def analytics
      # Your analytics logic here
    end

    def attendees
      # Your attendees logic here
    end

    private

    def require_admin
      redirect_to root_path, alert: "Not authorized" unless current_user.admin?
    end
  end
end