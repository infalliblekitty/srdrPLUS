Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :projects, concerns: :paginatable, shallow: true do
    resources :key_questions
    collection do
      get 'filter'
    end
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'static_pages#home'

  get 'help'  => 'static_pages#help'
  get 'about' => 'static_pages#about'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  resource :profile, only: [:show, :edit, :update]
  resources :degrees, only: [:index]
  resources :organizations, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

