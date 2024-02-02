class CreateShippingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :postal_code
      t.integer :shipping_area_id
      t.string :city
      t.string :address
      t.string :building_name
      t.string :phone_number
      t.references :purchase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
