Rails.application.routes.draw do
  root "core#index"

  get "dashboard", to: "dashboard#index"

  resources :user_sessions, only: [:new, :create]
  resources :users, only: [:new, :create]

  namespace :dashboard do
    resources :clients
    resources :projects, only: [:show, :new, :create, :edit, :update, :destroy]
    resources :teams, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :entries
    resources :users, only: [:show, :edit, :update]

    get 'set_active_team', to: 'teams#set_active_team'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
