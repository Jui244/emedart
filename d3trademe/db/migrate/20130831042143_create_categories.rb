class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :number
      t.string :path
    end
    add_index :categories, :number
  end
end
