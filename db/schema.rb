# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_14_130536) do
  create_table "food_items", force: :cascade do |t|
    t.integer "food_id", null: false
    t.string "name", null: false
    t.decimal "quantity", precision: 10, scale: 3, null: false
    t.string "unit", null: false
    t.string "storage_location"
    t.integer "status", default: 0, null: false
    t.date "expiration_date", null: false
    t.date "purchase_date"
    t.decimal "cost", precision: 8, scale: 2
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_food_items_on_food_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category", default: 0, null: false
    t.integer "typical_shelf_life"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meal_ingredients", force: :cascade do |t|
    t.integer "meal_id", null: false
    t.integer "food_id", null: false
    t.decimal "quantity_needed", precision: 10, scale: 3, null: false
    t.string "unit", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_meal_ingredients_on_food_id"
    t.index ["meal_id"], name: "index_meal_ingredients_on_meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.date "scheduled_for"
    t.datetime "completed_at"
    t.datetime "cancelled_at"
    t.integer "servings"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "food_items", "foods"
  add_foreign_key "meal_ingredients", "foods"
  add_foreign_key "meal_ingredients", "meals"
end
