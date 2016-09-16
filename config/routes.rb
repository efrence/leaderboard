Rails.application.routes.draw do
  resources :matches
  devise_for :users do
     get 'leaderboard', to: 'users/leaderboard#index'
  end
  root to: "users/leaderboard#index"
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'
end
