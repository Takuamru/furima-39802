class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:new, :create]
  before_action :redirect_if_purchased_or_owner, only: [:new, :create]

  def new
    @purchase = Purchase.new
  end

  def create
    # トランザクションを開始
    ActiveRecord::Base.transaction do
      @purchase = Purchase.new(user_id: current_user.id, item_id: params[:item_id])
      @purchase.save!

      shipping_address_params = purchase_params.except(:user_id, :item_id)
      @shipping_address = ShippingAddress.new(shipping_address_params)
      @shipping_address.purchase = @purchase
      @shipping_address.save!
    end

    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    # 保存に失敗した場合は、エラーメッセージを含めて購入ページを再表示
    render :new
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.require(:purchase).permit(:postal_code, :shipping_area_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def redirect_if_purchased_or_owner
    redirect_to root_path if @item.purchase.present? || current_user.id == @item.user_id
  end
end

