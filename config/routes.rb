Rails.application.routes.draw do
  resources :posts
  get '/', to: 'top#index'
end
