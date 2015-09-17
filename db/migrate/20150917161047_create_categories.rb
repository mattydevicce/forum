class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :subject

      t.timestamps null: false
    end
  end
end
