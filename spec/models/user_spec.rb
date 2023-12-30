require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザ登録ができる時' do
      it '全ての値が正しく入力されていれば登録できること' do
        expect(@user).to be_valid
      end

    context 'ユーザ登録ができない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
  
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
  
      it 'メールアドレスは一意である必要がある' do
        FactoryBot.create(:user, email: @user.email)
        @user.valid?
        expect(@user.errors.full_messages).to include "Email has already been taken"
      end
      
      it 'eメールアドレスに@が含まれる必要がある' do
        @user.email = 'testemail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      
      it 'パスワードは6文字以上である必要がある' do
        @user.password = 'a1'
        @user.password_confirmation = 'a1'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end

      it 'パスワードが半角英字のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
    
      it 'パスワードが半角数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
    
      it 'パスワードが全角では登録できないこと' do
        @user.password = 'ＡＢＣ１２３'
        @user.password_confirmation = 'ＡＢＣ１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      
      it 'パスワードとパスワード確認は一致する必要がある' do
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
  
      it '全角の名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      
      it '全角の名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      
      it '全角の名字が不適切な値では登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      
      it '全角の名前が不適切な値では登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      
      it 'カタカナの名字が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
    
      it 'カタカナの名前が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
    
      it 'カタカナの名字が全角カタカナでなければ登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
    
      it 'カタカナの名前が全角カタカナでなければ登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
      
      it '生年月日が必須であること' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
        end
      end
    end
  end
end