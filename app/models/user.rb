class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :email, :store_name
    has_many :transactions

    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}
    validates :name, presence: true
    validates :role, presence: true
    validates :branch, presence: true
    validates :store_name, presence: true
end
