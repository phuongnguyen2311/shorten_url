# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'urls#index'
  get '/:short_url', to: 'urls#show'
  get 'shortened/:short_url', to: 'urls#shortened', as: :shortened
  resource :urls, only: :create

  namespace :v1 do
    resource :decode, only: :create
    resource :encode, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
