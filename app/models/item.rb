class Item < ApplicationRecord
    belongs_to :category, optional: true
    belongs_to :user, optional: true
    has_many :transaction_details

    validates :name, presence: true
    validates :price, presence: true
    validates :cost, presence: true
end
