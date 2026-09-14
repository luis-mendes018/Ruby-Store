class AddConstraintsToCategories < ActiveRecord::Migration[8.1]
  def change
    change_column :categories, :name, :string, null: false, limit: 50
  end
end
