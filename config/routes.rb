Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users

  resources :subs, except: [:destroy]

  resources :posts, except: [:index, :destroy]

  resource :session, only: [:new, :create, :destroy]

end
