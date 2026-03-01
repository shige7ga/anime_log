Rails.application.routes.draw do
  resources :posts
  resources :users

  resource :login, only: %i[ new create ]
  resource :logout, only: %i[ show ]

  get '/', to: 'top#index'
end
