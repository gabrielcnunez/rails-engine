Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], to: 'merchants#all_items'
      end
      resources :items, only: [:index, :show, :create, :update]
    end
  end
end
