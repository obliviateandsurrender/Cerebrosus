class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :answer, limit: 10
      t.timestamps
    end
    add_reference :answers, :users, index: true
    add_foreign_key :answers, :users, index: true
    add_reference :answers, :questions, index: true
    add_foreign_key :answers, :questions, index: true
  end
end
