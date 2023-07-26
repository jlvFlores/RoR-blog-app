Rails.application.routes.draw do
  resources :posts, only: [:new, :create]

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
