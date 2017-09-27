class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.boolean :oauth, default: false, null: false
      t.string :hash, default: '', null: false
      t.timestamps
    end
    add_reference :sessions, :users, index: true
    add_foreign_key :sessions, :users, index: true
  end
end
