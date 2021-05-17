Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      devise_for :users, singular: :user, controllers: {
        registrations: 'api/v1/users/registrations',
        passwords: 'api/v1/users/passwords'
      }, skip: [:sessions]
      resources :points
    end
  end
end
