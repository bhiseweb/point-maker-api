FactoryBot.define do
  factory :point do
    creator
    name { Faker::Address.full_address }
    lonlat { "POINT(#{Faker::Address.longitude} #{Faker::Address.latitude})" }
  end

  after(:build) { |point|
    point.class.skip_callback(:save, :after, :add_to_firestore, raise: false)
    point.class.skip_callback(:destroy, :after, :delete_from_firestore, raise: false)
  }
end
