Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, path: '', path_names: { sign_in: 'login' }

  resources :posts, only: [:new, :create]

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
end
