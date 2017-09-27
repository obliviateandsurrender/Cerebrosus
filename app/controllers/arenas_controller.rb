class ArenasController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def index
    @quiz = Quiz.find(params[:qid])
    @subcategory = Subcategory.find(@quiz.subcategories_id)
    @category = Category.find(@subcategory.categories_id)
  end

  def quiz
    @quiz = Quiz.find(params[:qid])
    @questions = Question.where(quizzes_id: params[:qid]).all
    @answered = Answer.where(users_id: current_user.id).all
    @answers = []
    @questions.count.times do
      @answers << Answer.new
    end
  end

  def result
    @score = 0
    @quiz = Quiz.find(params[:qid])
    @subcategory = Subcategory.find(@quiz.subcategories_id)
    @category = Category.find(@subcategory.categories_id)
    @questions = Question.where(quizzes_id: params[:qid]).all
    @na = 0
    @wa = 0
    @ra = 0
    @questions.each do |question|
      @answer = Answer.find_by(questions_id: question.id, users_id: current_user.id)
      if !@answer.nil?
        if @answer.answer.to_s == question.answer.to_s
          @score += 10
          @ra += 1
        else
          @wa += 1
        end  
        Answer.find_by(questions_id: question.id, users_id: current_user.id).destroy
      else
        @na += 1
      end
    end
    score_params = {}
    score_params.merge!(quizzes_id: @quiz.id, users_id: current_user.id, score: @score)
    
    if !Score.find_by(quizzes_id: @quiz.id, users_id: current_user.id)
      Score.new(score_params).save
    else
      Score.find_by(quizzes_id: @quiz.id, users_id: current_user.id).update(score_params)
    end
  end

  private
  def arena_params
    params.permit(:qid, :page)
  end
  def record_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end
end
