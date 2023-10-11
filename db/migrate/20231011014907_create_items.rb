class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :category_id
      t.text :description
      t.boolean :is_available
      t.string :sold_by
      t.float :price
      t.float :cost
      t.string :sku
      t.string :barcode
      t.boolean :is_track
      t.integer :stock
      t.integer :low_stock
      t.integer :user_id

      t.timestamps
    end
  end
end
