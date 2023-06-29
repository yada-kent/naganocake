Rails.application.routes.draw do

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    get '/' => 'homes#top'
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
    resource :items, only: [:show, :index]
  end

  scope module: :public do
    resources :cart_items, only: [:index, :update, :destroy, :create]
    patch 'cart_items/destroy_all', to: 'cart_items#destroy_all'
  end


  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  root to: 'homes#top'

  get '/about' => 'homes#about', as:'about'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
