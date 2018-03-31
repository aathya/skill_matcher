Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: "users/registrations",
  }

  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new'
    end
  end

  resources :workers, only: [:index, :create, :destroy]
  resources :customers, only: [:index]

  authenticated(:user, lambda {|u| u.worker?}) do
    root 'workers#index'
  end

  authenticated(:user, lambda {|u| u.customer?}) do
    root 'customers#index'
  end

end
