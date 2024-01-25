require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    # 必要なデータの準備
    @purchase_form = FactoryBot.build(:purchase_form)
  end

  describe '商品購入' do
    context '購入がうまくいくとき' do
      it '必要な情報が全て存在すれば購入できる' do
        expect(@purchase_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @purchase_form.building_name = ''
        expect(@purchase_form).to be_valid
      end
    end

    context '購入がうまくいかないとき' do
      it '郵便番号が空だと購入できない' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号がハイフンなしでは購入できない' do
        @purchase_form.postal_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code is invalid")
      end

      it '都道府県が未選択では購入できない' do
        @purchase_form.shipping_area_id = 0
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Shipping area must be other than 0")
      end

      it '市区町村が空では購入できない' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @purchase_form.address = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では購入できない' do
        @purchase_form.phone_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が12桁以上では購入できない' do
        @purchase_form.phone_number = '123456789012'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が英数混合では購入できない' do
        @purchase_form.phone_number = 'abcd1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number is invalid")
      end

    end
  end
end
