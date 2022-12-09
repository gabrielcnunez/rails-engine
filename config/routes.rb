Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :find_all, only: :index, to: 'search#index'
      end
      namespace :items do
        resources :find, only: :index, to: 'search#index'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], to: 'items#merchant_items'
      end
      resources :items, only: [:index, :show, :create, :update] do
        resources :merchant, only: [:index], to: 'merchants#items_merchant'
      end
    end
  end
end
