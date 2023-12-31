class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.string :role
      t.string :branch
      t.string :store_name

      t.timestamps
    end
  end
end
