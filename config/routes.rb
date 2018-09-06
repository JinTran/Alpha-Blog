Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles do
    # match 'articles/id' => 'articles#show', via: [:get, :post]
    resources :comments
  end

  resources :books

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  resources :users, except: [:new]

  root 'welcome#index'
end
