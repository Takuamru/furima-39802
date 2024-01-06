class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :user, null: false, foreign_key: true
      t.integer :category_id
      t.integer :condition_id
      t.integer :shipping_fee_id
      t.integer :shipping_area_id
      t.integer :shipping_day_id

      t.timestamps
    end
  end
end
