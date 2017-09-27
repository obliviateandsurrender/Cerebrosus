class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to '/dashboard'
    end
  end

  def create
    user_info = request.env["omniauth.auth"]
    if user_info
      user_details = Hash.new
      user_details["name"] = user_info["info"]["name"]
      user_details["username"] = user_info["info"]["name"]
      user_details["email"] = user_info["info"]["email"]
      user_details["password"] = user_info["uid"]
      user_details["password_confirmation"] = user_info["uid"]
      @logger = User.find_by(email: user_info["info"]["email"])
      if !@logger
        @user = User.new(user_details)
        @user.save
        log_in @user
      else
        log_in @logger
      end
      redirect_to '/dashboard'
    else
      if logged_in?
        redirect_to '/dashboard'
      else
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          log_in user
          redirect_to '/dashboard'
          # Log the user in and redirect to the user's show page.
        else
          # Create an error message.
          # Not quite right!
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end   
      end
    end 
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
