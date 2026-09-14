class AddConstraintsToProducts < ActiveRecord::Migration[8.1]
  def change
    change_column :products, :name, :string, null: false, limit: 100
    change_column :products, :description, :text, limit: 900
    change_column :products, :price, :decimal, null: false, precision: 10, scale: 2
    change_column :products, :stock_quantity, :integer, null: false, default: 0
    change_column :products, :active, :boolean, null: false, default: true
  end
end
