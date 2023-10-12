require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root to: 'sessions#new'
  resources :mechanics
  resources :sessions
  resources :bookings
  resources :users
  resources :cars
  resources :addresses
  resources :admins
  resources :services
  get '/confirm', to: 'bookings#confirm'
  get '/cancel', to: 'bookings#cancel'
  get '/assinework', to:   'mechanics#assinework'
  get '/mechanic_booking', to:   'mechanics#mechanic_booking'
  get '/service_history', to:    'services#service_history'
  get '/service_update', to:    'services#service_update'
  get '/user_profile', to:     'users#user_profile'
  get '/dash_board', to:     'users#dash_board'
  get '/confirm', to: 'services#confirm_service'
  get '/cancel_service', to: 'services#cancel_service'
  get '/confirm_service', to: 'services#confirm_service'
  get '/view',to: 'mechanics#view'
  get '/admin_profile',to: 'admins#admin_profile'
  get '/admin_navbar',to: 'admins#admin_navbar'
end
