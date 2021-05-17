FactoryBot.define do
  factory :application, class: 'Doorkeeper::Application' do
    name { 'Ember Client' }
    redirect_uri { '' }
    scopes { '' }
  end
end
