class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items, id: :uuid do |t|
      t.references :order, type: :uuid, null: false, foreign_key: true
      t.references :product, type: :uuid, null: false, foreign_key: true

      t.string :product_name, null: false
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
