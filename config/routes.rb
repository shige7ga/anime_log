Rails.application.routes.draw do
  resources :posts
  resources :users
  get '/', to: 'top#index'
end
