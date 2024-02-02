class PurchaseForm
  include ActiveModel::Model

  attr_accessor :postal_code, :shipping_area_id, :city, :address, :building_name, :phone_number, :token, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :shipping_area_id, numericality: { other_than: 0 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    ActiveRecord::Base.transaction do
      # Purchaseオブジェクトの保存
      purchase = Purchase.create!(
        user_id: user_id,
        item_id: item_id
      )

      # ShippingAddressオブジェクトの保存
      ShippingAddress.create!(
        purchase_id: purchase.id,
        postal_code: postal_code,
        shipping_area_id: shipping_area_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number
      )
    end
  rescue ActiveRecord::RecordInvalid => e
    # エラーメッセージをログに記録
    Rails.logger.error e.message

    # ビューでエラーメッセージを表示するための準備
    @errors = e.record.errors.full_messages

    # トランザクションの失敗を示すために false を返す
    false
  end
end
