Rails.application.routes.draw do
  resources :posts, only: [:new, :create]

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:create]
      resources :likes, only: [:create]
    end
  end
end
