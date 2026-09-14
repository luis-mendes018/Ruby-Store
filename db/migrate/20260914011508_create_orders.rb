class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true

      t.string :status, null: false, default: "pending"

      t.string :name, null: false
      t.string :email, null: false

      t.string :cep, null: false
      t.string :street, null: false
      t.string :number, null: false
      t.string :complement
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :state, null: false

      t.decimal :total, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
