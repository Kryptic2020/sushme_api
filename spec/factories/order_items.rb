FactoryBot.define do
  factory :order_item do
    quantity { 1 }
    price { 1.5 }
    product { nil }
    order { nil }
  end
end
