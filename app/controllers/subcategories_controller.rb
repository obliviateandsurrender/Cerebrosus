class SubcategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    if logged_in?
      @subcategory = Subcategory.all
      @categories = Category.all
    else
      redirect_to '/signup'
    end
  end

  def new
    if !current_user.admin
      flash[:danger] = "Operation not allowed."
      redirect_back fallback_location: root_path
    end
    cat(params[:cat])
    @kitty = params[:cat]
    @subcategory = Subcategory.new
  end

  def edit
    if !current_user.admin
      flash[:danger] = "Operation not allowed."
      render file: "#{Rails.root}/public/422", layout: true, status: :not_found
    end
    @subcategory = Subcategory.find(params[:id])
    @kitty = @subcategory.categories_id
  end

  def update
    puts cat_params
    cata_params = {}
    cata_params.merge!(categories_id: cat_params[:categories_id], title: cat_params[:subcategory][:title])
    if Subcategory.find(params[:id]).update(cata_params)
      redirect_to subcategories_path
      flash[:success] = 'Subcategory was successfully updated.'
    else
      render categories_path
    end
  end

  def show
    @subcategory = Subcategory.find(params[:id])
    #subcat(params[:id])
    @quiz = Quiz.where(subcategories_id: params[:id])
  end

  def create
    cata_params = {}
    cata_params.merge!(categories_id: cat_params[:categories_id], title: cat_params[:subcategory][:title])
       
    @subcategory = Subcategory.new(cata_params)
    if @subcategory.save
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
    subcategory = Subcategory.where(id: params[:id]).all
    subcategory.each do |subcat|
      quizs =  Quiz.where(subcategories_id: subcat.id).all
      quizs.each do |quiz|
        Score.where(quizzes_id: quiz.id).destroy_all
        Question.where(quizzes_id: quiz.id).destroy_all
      end
      Quiz.where(subcategories_id: subcat.id).destroy_all
    end
    Subcategory.where(id: params[:id]).destroy_all
    
    flash[:success] = 'Subcategory was successfully destroyed.'
    redirect_to subcategories_url
  end
  
  private
  def cat_params
    params.permit(:id, :categories_id, subcategory: :title)
  end
  def record_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end

end
  