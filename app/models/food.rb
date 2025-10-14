class Food < ApplicationRecord
  has_many :food_items, dependent: :destroy

  enum :category, { fresh: 0, prepared: 1, pantry: 2 }
end
