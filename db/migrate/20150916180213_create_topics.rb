class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.belongs_to :user, index: true
      t.belongs_to :category, index: true
      t.string :title
      t.string :subject
      t.text :content

      t.timestamps null: false
    end
  end
end
