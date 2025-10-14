class CreateMeals < ActiveRecord::Migration[8.0]
  def change
    create_table :meals do |t|
      t.string :name, null: false
      t.integer :status, default: 0, null: false
      t.date :scheduled_for
      t.datetime :completed_at
      t.datetime :cancelled_at
      t.integer :servings
      t.text :notes

      t.timestamps
    end
  end
end
