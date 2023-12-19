# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| reading_name       | string | null: false               |
| birth_date         | date   | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
- has_many :items
- has_many :purchases

## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |  <!-- 出品者情報 -->
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| shipping_fee       | string     | null: false                    |
| shipping_area      | string     | null: false                    |
| shipping_days      | string     | null: false                    |
| image_url          | string     | null: false                    |

### Association
- belongs_to :user
- has_one    :purchase

## purchases テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |  <!-- 購入者情報 -->
| item            | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item