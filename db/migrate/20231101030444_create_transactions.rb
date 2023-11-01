class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.float :total_amount
      t.float :cash
      t.float :change
      t.boolean :is_void
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
