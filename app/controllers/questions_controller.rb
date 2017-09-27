class QuestionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
 def index
   if logged_in? && current_user.admin 
     @questions = Question.all
   else
     redirect_to '/signup'
   end
 end
 
 def new
  if !current_user.admin
    flash[:danger] = "Operation not allowed."
    redirect_back fallback_location: root_path
  end
   cat(params[:quiz])
   @kitty = params[:quiz]
   @question = Question.new
 end

 def edit
  if !current_user.admin
    flash[:danger] = "Operation not allowed."
    render file: "#{Rails.root}/public/422", layout: true, status: :not_found
  end
   @question = Question.find(params[:id])
   @kitty = @question.quizzes_id
 end
 
 def update
  quesa_params = {}
  puts ques_params
  ass = ''
  if ques_params[:question][:format] != 'Text'
    ass = ques_params[:question][:asset]
  end
  ans = ''
  ques_params[:question][:answer].each do |qu|
   ans += qu
  end
  if ans.length > 1
   mult = true
  else
   mult = false
  end
  quesa_params.merge!(format: ques_params[:question][:format], asset: ass, quizzes_id: ques_params[:quiz_id], body: ques_params[:question][:body], option1: ques_params[:question][:option1], option4: ques_params[:question][:option4], option2: ques_params[:question][:option2], option3: ques_params[:question][:option3], multiple: mult, answer: ans)

   if Question.find(params[:id]).update(quesa_params)
     redirect_to question_path
     flash[:success] = 'Question was successfully updated.'
   else
    flash[:error] = 'Please fill all the fields'
    redirect_back fallback_location: root_path
   end
 end
 
 def show
   @question = Question.find(params[:id])
 end
 
 def create
   quesa_params = {}
   puts ques_params
   ass = ''
   if ques_params[:question][:format] != 'Text'
     ass = ques_params[:question][:asset]
   end
   ans = ''
   ques_params[:question][:answer].each do |qu|
    ans += qu
   end
   if ans.length > 1
    mult = true
   else
    mult = false
   end
   quesa_params.merge!(format: ques_params[:question][:format], asset: ass, quizzes_id: ques_params[:quiz_id], body: ques_params[:question][:body], option1: ques_params[:question][:option1], option4: ques_params[:question][:option4], option2: ques_params[:question][:option2], option3: ques_params[:question][:option3], multiple: mult, answer: ans)
   @question = Question.new(quesa_params)
   if @question.save
     flash[:success] = "Question added!"
     redirect_to subcategories_path
     # Handle a successful save.
   else
     flash[:error] = "Try again!"
     redirect_back fallback_location: root_path
   end
 end
 
 def destroy
  if !current_user.admin
    flash[:danger] = "Operation not allowed."
    render file: "#{Rails.root}/public/422", layout: true, status: :not_found
  end
   que = Question.find(params[:id]) 
   Answer.where(questions_id: params[:id]).destroy_all
   Score.where(quizzes_id: que.quizzes_id).destroy_all 
   Question.find(params[:id]).destroy
   flash[:success] = 'Question was successfully destroyed.'
   redirect_to subcategories_url
 end
 
 private
 def ques_params
   params.permit(:id, :quiz_id, :answer, question: [ :asset, :body, :option1, :option2, :option3, :option4, :multiple, :format, answer:[]])
 end
 def record_not_found
  render file: "#{Rails.root}/public/404", layout: true, status: :not_found
 end
end