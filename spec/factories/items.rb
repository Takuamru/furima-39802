FactoryBot.define do
  factory :item do
    name { "テスト商品名" }
    description { "テスト商品の説明" }
    price { 5000 }
    association :user # ユーザーとの関連付け
    category_id { 2 }
    condition_id { 2 }
    shipping_fee_id { 2 }
    shipping_area_id { 2 }
    shipping_day_id { 2 }

    # 画像に関する設定
    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end

