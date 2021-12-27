FactoryBot.define do
  factory :order do
    total_amount { 1.5 }
    delivery_time { "2021-12-27 09:02:39" }
    isTakeAway { false }
    user { nil }
    payment { nil }
    status { nil }
    table { nil }
    customer { nil }
  end
end
