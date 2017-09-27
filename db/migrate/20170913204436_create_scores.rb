class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.integer :score, null: false
      t.timestamps
    end
    add_reference :scores, :users, index: true
    add_foreign_key :scores, :users, index: true
    add_reference :scores, :quizzes, index: true
    add_foreign_key :scores, :quizzes, index: true
  end
end
