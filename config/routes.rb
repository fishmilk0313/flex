Rails.application.routes.draw do
  root 'homes#top'

  get 'homes/top' => 'homes#top'
  get 'homes/about' => 'homes#about'
  devise_for :users

  resources :users do
  	member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
    resources :notifications, only: [:index, :destroy]
  resources :posts do
    resources :favorites, only: [:create, :destroy, :show]
  end
  resources :hashtags


  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
