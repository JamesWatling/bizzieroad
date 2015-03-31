Rails.application.routes.draw do
  resources :providers

  resources :companies

  namespace :api do
  	get '/get', to: 'companies#index', as: 'get_companies'
  end

  devise_for :users
  root to: 'dashboard#index'
end
