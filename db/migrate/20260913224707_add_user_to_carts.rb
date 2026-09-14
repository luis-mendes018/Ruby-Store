class AddUserToCarts < ActiveRecord::Migration[8.1]
  def change
    add_reference :carts,
                  :user,
                  null: false,
                  foreign_key: true

    add_index :carts,
              :user_id,
              unique: true
  end
end
