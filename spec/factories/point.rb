FactoryBot.define do
  factory :point do
    name { "New Point" }
    lonlat  { 32.949494 }
    longitude { 77.3939393 }
  end

  after(:build) { |point|
    point.class.skip_callback(:save, :after, :add_to_firestore, raise: false)
    point.class.skip_callback(:destroy, :after, :delete_from_firestore, raise: false)
  }

end