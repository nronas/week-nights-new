WeekNights::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resource :dashboard, only: :show

  namespace :dashboard do
    resources :movies, only: [:new, :create, :show, :update] do
      collection do
        get :find
      end

      resources :votes, only: :create
    end
  end
end
