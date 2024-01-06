class Item < ApplicationRecord
  belongs_to :user
  #has_one :purchase

  with_options presence: true do
    validates :name
    validates :description
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
    validates :category_id, :condition_id, :shipping_fee_id, :shipping_area_id, :shipping_day_id, numericality: { other_than: 0 }
end
