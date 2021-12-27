class Order < ApplicationRecord
  belongs_to :user
  belongs_to :payment
  belongs_to :status
  belongs_to :table
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items, dependent: :destroy
end
