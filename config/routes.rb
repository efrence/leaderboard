Rails.application.routes.draw do
  resources :matches
  devise_for :users
  root to: "home#index"
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'
end
