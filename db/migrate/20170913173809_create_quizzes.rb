class CreateQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.string :title, limit: 30, default: '', null: false
      t.datetime :updated_at
      t.boolean :is_playable, default: false, null: false
      t.timestamps
    end
    add_reference :quizzes, :subcategories, index: true
    add_foreign_key :quizzes, :subcategories, index: true
  end
end
