# frozen_string_literal: true

FactoryBot.define do
  factory :point do
    created_by
    name { Faker::Address.full_address }
    lonlat { "POINT(#{Faker::Address.longitude} #{Faker::Address.latitude})" }
  end

  after(:build) do |point|
    point.class.skip_callback(:save, :after, :add_to_firestore, raise: false)
    point.class.skip_callback(:destroy, :after, :delete_from_firestore, raise: false)
  end
end
