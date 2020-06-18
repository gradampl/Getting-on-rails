# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  resources :articles do
    resources :comments
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
