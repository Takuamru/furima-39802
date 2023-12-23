class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ニックネーム、メールアドレス、パスワードの必須チェック
  validates :nickname, :email, :password, presence: true
        
  # メールアドレスの一意性と@の含有
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
        
  # パスワードの長さとフォーマット（6文字以上、半角英数字混合）
  validates :password, length: { minimum: 6 }, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/ }
        
  # 本人情報確認のバリデーション
  validates :last_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ }
  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :birth_date, presence: true

end
