class ChangeActiveStorageRecordIdToString < ActiveRecord::Migration[8.1]
  def change
    change_column :active_storage_attachments,
                  :record_id,
                  :string,
                  null: false
  end
end
