# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[created_by] do
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alpha }
  end
end
