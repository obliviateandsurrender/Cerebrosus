class CreateSubcategories < ActiveRecord::Migration[5.1]
  def change
    create_table :subcategories do |t|
      t.string :title
      t.timestamps
    end
    add_reference :subcategories, :categories, index: true
    add_foreign_key :subcategories, :categories, index: true
  end
end
