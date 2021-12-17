FactoryBot.define do
  factory :product do
    title { "MyString" }
    price { 1.5 }
    description { "MyText" }
    status { "MyString" }
    category { nil }
  end
end
