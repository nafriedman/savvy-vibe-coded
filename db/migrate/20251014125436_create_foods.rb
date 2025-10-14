class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.integer :category, default: 0, null: false
      t.integer :typical_shelf_life

      t.timestamps
    end
  end
end
