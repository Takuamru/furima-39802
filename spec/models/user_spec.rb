require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
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
    
    it 'パスワードとパスワード確認は一致する必要がある' do
      @user.password_confirmation = 'different'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it '全角の名字と名前がそれぞれ必須であること' do
      @user.last_name = ''
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", "First name can't be blank")
    end
    
    it '全角の名字と名前は漢字・ひらがな・カタカナで入力する必要があること' do
      @user.last_name = 'yamada'
      @user.first_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name is invalid", "First name is invalid")
    end
    
    it 'カタカナの名字と名前がそれぞれ必須であること' do
      @user.last_name_kana = ''
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank", "First name kana can't be blank")
    end
    
    it 'カタカナの名字と名前は全角カタカナで入力する必須であること' do
      @user.last_name_kana = 'やまだ'
      @user.first_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana is invalid", "First name kana is invalid")
    end
    
    it '生年月日が必須であること' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end