Rails.application.routes.draw do

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    get '/' => 'homes#top'
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  scope module: :public do
    resource :customers, only: [:show, :edit, :update]
    get 'customers/confirm_delete', to: 'customers#confirm_delete'
    patch 'customers/unsubscribe', to: 'customers#unsubscribe'
  end

  scope module: :public do
    resources :items, only: [:show, :index]
  end

  scope module: :public do
    delete 'cart_items/destroy_all', to: 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
  end

  scope module: :public do
      post 'orders/confirm', to: 'orders#confirm'
    get 'orders/complete', to: 'orders#complete'
    get 'orders/history', to: 'orders#index', as: 'orders/history'
    resources :orders, only: [:new, :create, :show]

  end


  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: 'homes#top'

  get '/about' => 'homes#about', as:'about'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
