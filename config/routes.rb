Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'search', to:'search#index'
  resources :courses do
    collection do
      get 'search'
    end
  end
  resources :sections do
    collection do
      get 'search'
    end
  end
  resources :offices do
    collection do
      get 'search'
    end
  end
  resources :teachers do
    collection do
      get 'search'
    end
  end
end
