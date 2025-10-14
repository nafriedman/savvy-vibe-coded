# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create Food types
salmon = Food.find_or_create_by!(name: "Salmon", category: :fresh, typical_shelf_life: 2)
chicken = Food.find_or_create_by!(name: "Chicken Breast", category: :fresh, typical_shelf_life: 3)
milk = Food.find_or_create_by!(name: "Milk", category: :fresh, typical_shelf_life: 7)
pasta = Food.find_or_create_by!(name: "Pasta", category: :pantry, typical_shelf_life: 365)
rice = Food.find_or_create_by!(name: "Rice", category: :pantry, typical_shelf_life: 365)
leftover_pizza = Food.find_or_create_by!(name: "Leftover Pizza", category: :prepared, typical_shelf_life: 3)
tomato_sauce = Food.find_or_create_by!(name: "Tomato Sauce", category: :pantry, typical_shelf_life: 180)
broccoli = Food.find_or_create_by!(name: "Broccoli", category: :fresh, typical_shelf_life: 5)

puts "Created #{Food.count} food types"

# Create Food Items
FoodItem.find_or_create_by!(
  food: salmon,
  name: "Fresh Atlantic Salmon",
  quantity: 1.5,
  unit: "lbs",
  storage_location: "Fridge",
  status: :available,
  expiration_date: Date.today + 1.day,
  purchase_date: Date.today - 1.day,
  cost: 18.99,
  notes: "From Whole Foods"
)

FoodItem.find_or_create_by!(
  food: chicken,
  name: "Organic Chicken Breast",
  quantity: 2,
  unit: "lbs",
  storage_location: "Freezer",
  status: :available,
  expiration_date: Date.today + 30.days,
  purchase_date: Date.today - 2.days,
  cost: 12.50
)

FoodItem.find_or_create_by!(
  food: milk,
  name: "Whole Milk",
  quantity: 0.5,
  unit: "gallon",
  storage_location: "Fridge",
  status: :available,
  expiration_date: Date.today + 5.days,
  purchase_date: Date.today - 2.days,
  cost: 4.99
)

FoodItem.find_or_create_by!(
  food: pasta,
  name: "Penne Pasta",
  quantity: 1,
  unit: "box",
  storage_location: "Pantry",
  status: :available,
  expiration_date: Date.today + 180.days,
  purchase_date: Date.today - 30.days,
  cost: 2.99
)

FoodItem.find_or_create_by!(
  food: broccoli,
  name: "Fresh Broccoli",
  quantity: 1,
  unit: "bunch",
  storage_location: "Fridge",
  status: :available,
  expiration_date: Date.today + 3.days,
  purchase_date: Date.today,
  cost: 3.49
)

FoodItem.find_or_create_by!(
  food: leftover_pizza,
  name: "Pepperoni Pizza",
  quantity: 4,
  unit: "slices",
  storage_location: "Fridge",
  status: :available,
  expiration_date: Date.today + 2.days,
  purchase_date: Date.today - 1.day,
  cost: 8.00,
  notes: "From dinner last night"
)

# Add an expired item
FoodItem.find_or_create_by!(
  food: milk,
  name: "Expired Milk",
  quantity: 0.25,
  unit: "gallon",
  storage_location: "Fridge",
  status: :available,
  expiration_date: Date.today - 2.days,
  purchase_date: Date.today - 10.days,
  cost: 4.99
)

puts "Created #{FoodItem.count} food items"
puts "Seeding complete!"
