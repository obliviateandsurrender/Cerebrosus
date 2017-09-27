class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :body, default: '', null: false
      t.string :option1, default: '', null: false
      t.string :option2, default: '', null: false
      t.string :option3, default: '', null: false
      t.string :option4,  default: '', null: false
      t.string :answer,  default: '', null: false
      t.string :format, default: 'text', null: false
      t.string :asset, default: ''  
      t.boolean :multiple, default: false, null: false
      t.datetime :updated_at
      t.timestamps
    end
    add_reference :questions, :quizzes, index: true
    add_foreign_key :questions, :quizzes, index: true
  end
end