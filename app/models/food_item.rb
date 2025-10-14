class FoodItem < ApplicationRecord
  belongs_to :food

  enum :status, { available: 0, consumed: 1, thrown_out: 2, given_away: 3 }
end
