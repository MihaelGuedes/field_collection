Rails.application.routes.draw do
  default_url_options host: 'http://localhost:3000'

  get 'visits/:id/checkin' => 'visits#checkin_at'
  get 'visits/:id/checkout' => 'visits#checkout_at'

  resources :visits
  resources :answers
  resources :authorization, only: [:create]

  resources :users do
    resource :visits, only: [:show]
    resource :visits, only: [:show], path: 'relationship/visits'
  end

  resources :formularies do
    resource :questions, only: [:show]
    resource :questions, only: [:show], path: 'relationship/questions'
  end

  resources :questions do
    resource :answer, only: [:show]
    resource :answer, only: [:show], path: 'relationship/answer'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
