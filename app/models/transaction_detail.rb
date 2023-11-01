class TransactionDetail < ApplicationRecord
  belongs_to :item
  belongs_to :my_transaction, class_name: "Transaction", foreign_key: "transaction_id"
end
