class DashboardController < ApplicationController
  def index
    puts logged_in?
    puts current_user
    if current_user.admin
      render 'admin'
    else
      render 'user'
    end
  end 

  def user
    @user = current_user
  end

  def admin
    @user = current_user
  end
end