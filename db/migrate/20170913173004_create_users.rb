class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 50, default: '', null: false
      t.string :email, default: '', null: false
      t.string :password_digest, null: false
      t.string :username, limit: 20, null:false
      t.boolean :admin, default: false
      t.integer :signin_count, default: 0, null:false
      t.boolean :rememberme_token,  default: false
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
