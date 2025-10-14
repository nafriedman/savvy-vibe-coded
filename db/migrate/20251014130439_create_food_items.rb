class CreateFoodItems < ActiveRecord::Migration[8.0]
  def change
    create_table :food_items do |t|
      t.references :food, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :quantity, precision: 10, scale: 3, null: false
      t.string :unit, null: false
      t.string :storage_location
      t.integer :status, default: 0, null: false
      t.date :expiration_date, null: false
      t.date :purchase_date
      t.decimal :cost, precision: 8, scale: 2
      t.text :notes

      t.timestamps
    end
  end
end
