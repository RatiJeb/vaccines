require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
    root to: "main#index"
    resources :users
    resources :vaccine_items
    resources :bookings
    resources :patients
    resources :business_unit_slots
    resources :business_units
    get 'countries/fetch_cities'
    get 'cities/fetch_districts'
    resources :countries
    resources :cities
    resources :districts
    resources :orders
    resources :sms_messages, only: [:index]
  end

  root to: "main#index"

  get 'slots/fetch_cities'
  get 'slots/fetch_districts'
  get 'slots/fetch_business_units'
  get 'cancel_order/order_found'
  post 'cancel_order/send_verification'
  post 'cancel_order/verify_code'

  resources :slots, only: [:index]
  resources :cancel_order, only: [:index]

  match 'booking/:vaccine', to: 'main#current_step', via: :get, as: :current_step
  match 'next_step', to: 'main#next_step', via: :post
  match 'prev_step', to: 'main#prev_step', via: :post
end
