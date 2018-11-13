Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users do
    resources :reservation
    resources :player
    resources :reviews
  end

  resources :clubs do
    resources :fields do
      resources :reservations
    end
    resources :reviews
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
