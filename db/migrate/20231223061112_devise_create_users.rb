# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :nickname, null: false
      t.string :email, null: false, unique: true
      t.string :encrypted_password, null: false
      t.date :birth_date, null: false

    ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      
      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end
  end
end
