class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :picture
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items, dependent: :destroy
end
