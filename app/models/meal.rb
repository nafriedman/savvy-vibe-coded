class Meal < ApplicationRecord
  has_many :meal_ingredients, dependent: :destroy

  enum :status, { scheduled: 0, completed: 1, cancelled: 2 }
end
