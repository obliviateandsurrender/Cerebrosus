class AnswersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def new
  end

  def create
    puts ans_params
    ansa_params = {}
    @question = Question.find(params[:question_id])
    as = ''
    if !ans_params[:answer].nil?
      if !@question.multiple
        puts 'Here'
        if @question.option1 == ans_params[:answer][:answer]
          as += '1'
        end
        if @question.option2 == ans_params[:answer][:answer]
          as += '2'
        end
        if @question.option3 == ans_params[:answer][:answer]
          as += '3'
        end
        if @question.option4 == ans_params[:answer][:answer]
          as += '4'
        end       
      else
        puts 'There'
        if ans_params[:answer]['answer1'].to_s == '1'
          as += '1'
        end
        if ans_params[:answer]['answer2'].to_s == '1'
          as += '2'
        end
        if ans_params[:answer]['answer3'].to_s == '1'
          as += '3'
        end
        if ans_params[:answer]['answer4'].to_s == '1'
          as += '4'
        end
      end
    end
    
    ansa_params.merge!(questions_id: ans_params[:question_id], users_id: current_user.id, answer: as)
    
    if !Answer.find_by(questions_id: params[:question_id], users_id: current_user.id)
      @answer = Answer.new(ansa_params)
      @answer.save
    else
      Answer.find_by(questions_id: params[:question_id], users_id: current_user.id).update(ansa_params)
    end
    redirect_back fallback_location: root_path
  end

  def reset
    ansa_params = {}
    @question = Question.find(params[:question_id])
    as = ''
    ansa_params.merge!(questions_id: ans_params[:question_id], users_id: current_user.id, answer: as)
    if Answer.find_by(questions_id: params[:question_id], users_id: current_user.id)
       Answer.find_by(questions_id: params[:question_id], users_id: current_user.id).delete
    end
    redirect_back fallback_location: root_path
  end

  def update
  end

  private
  def ans_params
    params.permit(:question_id, answer: [:answer, :answer1, :answer2, :answer3, :answer4  ])
  end
  def record_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end
end
