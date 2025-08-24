# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             defaults: { format: :json },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  namespace :v1 do
    post 'login', to: 'authentications#create'
    resources :examples
    resources :hello, only: [:index]
  end
end
