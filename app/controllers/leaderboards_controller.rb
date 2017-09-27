class LeaderboardsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def category
    @category = Category.find(params[:cid])
    subcategory = Subcategory.where(categories_id: params[:cid]).all
    @users = []
    score = []
    temp = []
    subcategory.each do |subcategory|
      quizes = Quiz.where(subcategories_id: subcategory.id)
      quizes.each do |quiz|
        lore = Score.where(quizzes_id: quiz.id).all
        lore.each do |lo|
          if temp.include? lo.users_id
            score.select{ |element| element[:users_id] == lo.users_id }.first[:score] += lo.score
          else
            temp << lo.users_id
            score << lo
          end
        end
      end
    end
    @score = score.sort_by { |k| k["score"] }.reverse!
    @score.each do |score|
      ar = {}
      ar.merge!(name: User.find(score.users_id).name, username: User.find(score.users_id).username, email: User.find(score.users_id).email, score: score.score)
      @users << ar
    end
  end

  def subcategory
    @subcategory = Subcategory.find(params[:sid])
    quizes = Quiz.where(subcategories_id: params[:sid])
    @users = []
    score = []
    temp = []
    quizes.each do |quiz|
      lore = Score.where(quizzes_id: quiz.id).all
      lore.each do |lo|
        if temp.include? lo.users_id
          score.select{ |element| element[:users_id] == lo.users_id }.first[:score] += lo.score
        else
          temp << lo.users_id
          score << lo
        end
      end
    end
    @score = score.sort_by { |k| k["score"] }.reverse!
    @score.each do |score|
      ar = {}
      ar.merge!(name: User.find(score.users_id).name, username: User.find(score.users_id).username, email: User.find(score.users_id).email, score: score.score)
      @users << ar
    end
  end

  def quiz
    @quiz = Quiz.find(params[:qid])
    score = Score.where(quizzes_id: params[:qid]).all
    @score = score.sort_by { |k| k["score"] }.reverse!
    @users = []
    @score.each do |score|
      ar = {}
      ar.merge!(name: User.find(score.users_id).name, username: User.find(score.users_id).username, email: User.find(score.users_id).email, score: score.score)
      @users << ar
    end
  end

  private
  def lead_params
    params.permit(:cid, :sid, :qid)
  end
  def record_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end
end
