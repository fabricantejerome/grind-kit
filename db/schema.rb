# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_01_034509) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "category_id"
    t.text "description"
    t.boolean "is_available"
    t.string "sold_by"
    t.float "price"
    t.float "cost"
    t.string "sku"
    t.string "barcode"
    t.boolean "is_track"
    t.integer "stock"
    t.integer "low_stock"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transaction_details", force: :cascade do |t|
    t.float "price"
    t.integer "quantity"
    t.float "total"
    t.integer "item_id", null: false
    t.integer "transaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_transaction_details_on_item_id"
    t.index ["transaction_id"], name: "index_transaction_details_on_transaction_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.float "total_amount"
    t.float "cash"
    t.float "change"
    t.boolean "is_void"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "role"
    t.string "branch"
    t.string "store_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "transaction_details", "items"
  add_foreign_key "transaction_details", "transactions"
  add_foreign_key "transactions", "users"
end
