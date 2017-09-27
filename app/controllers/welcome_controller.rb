class WelcomeController < ApplicationController
  def index
    if logged_in?
      redirect_to '/dashboard'
    end
  end

  def about
  end

  def help
  end
end
