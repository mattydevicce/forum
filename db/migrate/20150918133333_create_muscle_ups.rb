class CreateMuscleUps < ActiveRecord::Migration
  def change
    create_table :muscle_ups do |t|
      t.integer :total
      t.references :comment, index: true, foreign_key: true
      t.references :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
