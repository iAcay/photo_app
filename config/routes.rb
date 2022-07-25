Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :webhooks, only: %i[create]
  post 'checkout_create', to: 'checkout#create'
  resources :images
end
