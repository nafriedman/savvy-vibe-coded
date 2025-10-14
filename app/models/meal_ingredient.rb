class MealIngredient < ApplicationRecord
  belongs_to :meal
  belongs_to :food
end
