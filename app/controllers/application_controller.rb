class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include DashboardHelper
  include CategoriesHelper
  include SubcategoriesHelper
  def home
    if !logged_in?
      render application.html.erb
    else
      redirect_to '/dashboard'  
    end
  end
  def record_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end
end