require_relative '../lib/api_constraints'

Rails.application.routes.draw do
  devise_for :users

  # Module namespace but under '/', not adding api as a path prefix
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, except: :index
      resources :sessions, only: [:create, :destroy]
    end
  end
end
