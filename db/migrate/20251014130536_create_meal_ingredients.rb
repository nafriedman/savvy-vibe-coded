class CreateMealIngredients < ActiveRecord::Migration[8.0]
  def change
    create_table :meal_ingredients do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.decimal :quantity_needed, precision: 10, scale: 3, null: false
      t.string :unit, null: false
      t.text :notes

      t.timestamps
    end
  end
end
