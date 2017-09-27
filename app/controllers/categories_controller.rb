class CategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    if logged_in?
      @category = Category.all
    else
      redirect_to '/signup'
    end
  end

  def new
    if current_user.admin
      @category = Category.new
    else
      flash[:danger] = "Operation not allowed."
      redirect_back fallback_location: root_path
    end 
  end

  def edit
    if current_user.admin
      @category = Category.find(params[:id])
    else
      flash[:danger] = "Operation not allowed."
      render file: "#{Rails.root}/public/422", layout: true, status: :not_found
    end   
  end

  def update
    if Category.find(params[:id]).update(cat_params)
      redirect_to categories_path
      flash[:success] = 'Category was successfully updated.'
    else
      render categories_path
    end
  end

  def show
    puts params
    puts Subcategory.find_by(categories_id: params[:id])
    @category = Category.find(params[:id])
    subcat(params[:id])
    @subcategory =Subcategory.where(categories_id: params[:id])
    puts @subcategory
  end

  def create
    @category = Category.new(cat_params)
    if @category.save
      flash[:success] = "Category added!"
      redirect_to categories_path
      # Handle a successful save.
    else
      flash[:error] = "Try again!"
      redirect_to categories_path
    end
  end

  def destroy
    if !current_user.admin
      flash[:danger] = "Operation not allowed."
      render file: "#{Rails.root}/public/422", layout: true, status: :not_found
    end

    subcategory = Subcategory.where(categories_id: params[:id]).all
    subcategory.each do |subcat|
      quizs =  Quiz.where(subcategories_id: subcat.id).all
      quizs.each do |quiz|
        Score.where(quizzes_id: quiz.id).destroy_all
        Question.where(quizzes_id: quiz.id).destroy_all
      end
      Quiz.where(subcategories_id: subcat.id).destroy_all
    end
    Subcategory.where(categories_id: params[:id]).destroy_all
    Category.where(id: params[:id]).destroy_all
    
    flash[:success] = 'Category was successfully destroyed.'
    redirect_to categories_url
  end

  private
  def cat_params
    params.require(:category).permit(:id,:title)
  end
  def record_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end

end
