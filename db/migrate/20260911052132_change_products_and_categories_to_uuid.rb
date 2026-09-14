class ChangeProductsAndCategoriesToUuid < ActiveRecord::Migration[8.1]
  def change
    enable_extension "pgcrypto"

    remove_foreign_key :products, :categories

    execute "ALTER TABLE products DROP CONSTRAINT products_pkey"
    execute "ALTER TABLE categories DROP CONSTRAINT categories_pkey"

    remove_column :products, :category_id
    remove_column :products, :id
    remove_column :categories, :id

    add_column :categories,
               :id,
               :uuid,
               default: -> { "gen_random_uuid()" },
               null: false

    add_column :products,
               :id,
               :uuid,
               default: -> { "gen_random_uuid()" },
               null: false

    add_column :products,
               :category_id,
               :uuid,
               null: false

    execute "ALTER TABLE categories ADD PRIMARY KEY (id)"
    execute "ALTER TABLE products ADD PRIMARY KEY (id)"

    add_foreign_key :products, :categories
  end
end
