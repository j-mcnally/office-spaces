Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    resources :tags
    resources :users
    resources :rooms
    resources :pings
  end

  resources :rooms
  resources :tags

  root to: "rooms#index"
end
