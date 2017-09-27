class QuizzesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
   if logged_in?
     @quiz = Quiz.all
     @attempted = Score.where(users_id: current_user.id).all
     @subcategories = Subcategory.all
   else
     redirect_to '/signup'
   end
 end
 
 def new
  if !current_user.admin
    flash[:danger] = "Operation not allowed."
    redirect_back fallback_location: root_path
  end
   cat(params[:subcat])
   @kitty = params[:subcat]
   @quiz = Quiz.new
 end

 def edit
  if !current_user.admin
    flash[:danger] = "Operation not allowed."
    render file: "#{Rails.root}/public/422", layout: true, status: :not_found
  end
   @quiz = Quiz.find(params[:id])
   @kitty = @quiz.subcategories_id
 end
 
 def update
  quiza_params = {}
  quiza_params.merge!(subcategories_id: quiz_params[:subcategories_id], title: quiz_params[:quiz][:title])
   if Quiz.find(params[:id]).update(quiza_params)
     redirect_to subcategories_path
     flash[:success] = 'Quiz was successfully updated.'
   else
     render categories_path
   end
 end
 
 def show
   @quiz = Quiz.find(params[:id])
   @question = Question.where(quizzes_id: @quiz.id)
 end
 
 def create
   quiza_params = {}
   quiza_params.merge!(subcategories_id: quiz_params[:subcategories_id], title: quiz_params[:quiz][:title])
   @quiz = Quiz.new(quiza_params)
   if @quiz.save
     flash[:success] = "Subcategory added!"
     redirect_to subcategories_path
     # Handle a successful save.
   else
     flash[:error] = "Try again!"
     redirect_to subcategories_path
   end
 end
 
 def destroy
  if !current_user.admin
    flash[:danger] = "Operation not allowed."
    render file: "#{Rails.root}/public/422", layout: true, status: :not_found
  end
    quizs =  Quiz.where(id: params[:id]).all
    quizs.each do |quiz|
      Score.where(quizzes_id: quiz.id).destroy_all
      Question.where(quizzes_id: quiz.id).destroy_all
    end
    Quiz.where(id: params[:id]).destroy_all

    flash[:success] = 'Subcategory was successfully destroyed.'
    redirect_to subcategories_url
 end
 
 private
 def quiz_params
   params.permit(:id, :subcategories_id, quiz: :title)
 end
 def record_not_found
  render file: "#{Rails.root}/public/404", layout: true, status: :not_found
 end
end
 