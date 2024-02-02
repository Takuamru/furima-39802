FactoryBot.define do
  factory :purchase_form do
    postal_code      { '123-4567' }
    shipping_area_id { Faker::Number.between(from: 2, to: 48) }
    city             { Faker::Address.city }
    address          { Faker::Address.street_address }
    building_name    { Faker::Address.secondary_address }
    phone_number     { Faker::Number.leading_zero_number(digits: 10) }
    token            { 'tok_abcdefghijk00000000000000000' }
    # user_id と item_id はテスト実行時に指定する
  end
end
