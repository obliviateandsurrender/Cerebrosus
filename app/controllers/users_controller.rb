class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    if logged_in?
      @users = User.all    
    else 
      redirect_to '/signup'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
      @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user.admin || @user.id == current_user.id 
      @user = User.find(params[:id])
    else
      flash[:error] = "Operation not allowed."
      render file: "#{Rails.root}/public/422", layout: true, status: :not_found
    end
  end

  def update
    
    if User.find(params[:id]).update(user_params)
      redirect_to users_path
      flash[:success] = 'Category was successfully updated.'
    else
      render users_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the family, now login and come onboard!"
      redirect_to '/login'
    else
      render 'new'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.admin
      counts = User.where(admin: true).all.count
      if counts > 1
        User.find(params[:id]).destroy
        flash[:success] = "User deleted"
      else
        flash[:danger] = "Atleast one admin should be there!"
        render file: "#{Rails.root}/public/422", layout: true, status: :not_found
      end
    end
    redirect_back fallback_location: root_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :username ,:email, :password, :password_confirmation)
    end
    
    def record_not_found
      render file: "#{Rails.root}/public/404", layout: true, status: :not_found
    end
end
