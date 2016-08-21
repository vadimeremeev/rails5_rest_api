Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions"
    }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :timezones do
        get 'search' => 'timezones#search', on: :collection
      end
      resources :users do
        get 'logout' => 'users#logout', on: :collection
        get 'search' => 'users#search', on: :collection
      end
    end
  end

  root to: "application#index"
end
