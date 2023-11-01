class Transaction < ApplicationRecord
  belongs_to :user
  has_many :transaction_details
end
