Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products
      resources :users, only: [:create]
      post 'users/login', to: 'users#login'
    end
  end
end
