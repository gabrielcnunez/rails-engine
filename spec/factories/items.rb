FactoryBot.define do
  factory :item do
    merchant
    name { Faker::Beer.brand }
    description { Faker::Beer.name }
    unit_price { Faker::Number.between(from: 1.99, to: 9.99) }
  end
end