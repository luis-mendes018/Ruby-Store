class CreateActionTextTables < ActiveRecord::Migration[6.0]
  def change
    key_type = configured_primary_key_type

    create_table :action_text_rich_texts, id: key_type do |t|
      t.string :name, null: false
      t.text :body, size: :long

      t.references :record,
                   null: false,
                   polymorphic: true,
                   index: false,
                   type: :uuid

      t.timestamps

      t.index [ :record_type, :record_id, :name ],
              name: "index_action_text_rich_texts_uniqueness",
              unique: true
    end
  end

  private

  def configured_primary_key_type
    config = Rails.configuration.generators
    setting = config.options[config.orm][:primary_key_type]

    setting || :primary_key
  end
end
