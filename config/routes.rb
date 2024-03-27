# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    # Redirect signing out users back to sign-in
    delete 'users/sign_out', to: 'devise/sessions#destroy'
  end

  root to: 'events#index'

  resources :events

  namespace :events do
    resources :events, only: [] do
      resources :tickets, only: %i[new create index]
    end
  end
end
