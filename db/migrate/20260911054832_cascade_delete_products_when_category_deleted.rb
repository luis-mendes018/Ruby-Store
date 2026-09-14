class CascadeDeleteProductsWhenCategoryDeleted < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :products, :categories

    add_foreign_key :products,
                    :categories,
                    on_delete: :cascade
  end
end
