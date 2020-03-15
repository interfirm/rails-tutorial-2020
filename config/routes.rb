Rails.application.routes.draw do
  devise_for :admins
  root 'home#index'

  namespace :admins do
    resources :rooms, only: %i[index show]
  end
  get 'rooms/enter', to: 'rooms#enter'

  namespace :api do
    namespace :admins do
      post 'read_message/:id', to: 'rooms#update'
    end
    post 'read_message/:id', to: 'rooms#update'
  end

  mount ActionCable.server => '/cable'
end
