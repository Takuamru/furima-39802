class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:new, :create]
  before_action :redirect_if_purchased_or_owner, only: [:new, :create]

  def new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_form_params)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]

    if @purchase_form.valid?
      begin
        ActiveRecord::Base.transaction do
          charge = Payjp::Charge.create(
            amount: @item.price,
            card: @purchase_form.token,
            currency: 'jpy'
          )

          @purchase_form.save
        end

        redirect_to root_path
      rescue Payjp::PayjpError => e
        flash.now[:alert] = '支払い処理に失敗しました。'
        render :new
      rescue ActiveRecord::RecordInvalid => e
        # トランザクション内での例外処理
        Rails.logger.error e.message
        @errors = e.record.errors.full_messages
        flash.now[:alert] = '保存に失敗しました'
        render :new
      end
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      @errors = @purchase_form.errors.full_messages
      flash.now[:alert] = '保存に失敗しました'
      render :new
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_form_params
    #name属性を指定しているのでtokenの記載箇所はpermitで正しい（メンターに質問済み）
    params.require(:purchase_form).permit(:postal_code, :shipping_area_id, :city, :address, :building_name, :phone_number, :token).merge(user_id: current_user.id, item_id: @item.id)
  end

  def redirect_if_purchased_or_owner
    redirect_to root_path if @item.purchase.present? || current_user.id == @item.user_id
  end  
end
