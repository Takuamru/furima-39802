FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    price { 1 }
    user { nil }
    category_id { 1 }
    condition_id { 1 }
    shipping_fee_id { 1 }
    shipping_area_id { 1 }
    shipping_day_id { 1 }
  end
end
