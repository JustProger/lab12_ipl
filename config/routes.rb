# frozen_string_literal: true

Rails.application.routes.draw do
  root 'session#login'
  resources :calcs
  post 'session/create'
  get 'session/logout'
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
