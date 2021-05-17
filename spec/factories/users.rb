FactoryBot.define do
  factory :user, aliases: %i[creator] do
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alpha }
  end
end
