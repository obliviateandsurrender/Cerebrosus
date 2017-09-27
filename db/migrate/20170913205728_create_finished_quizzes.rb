class CreateFinishedQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :finished_quizzes do |t|
      t.timestamps
    end
    add_reference :finished_quizzes, :users, index: true
    add_foreign_key :finished_quizzes, :users, index: true
    add_reference :finished_quizzes, :quizzes, index: true
    add_foreign_key :finished_quizzes, :quizzes, index: true
  end
end
