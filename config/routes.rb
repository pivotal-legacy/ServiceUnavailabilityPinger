Sup::Application.routes.draw do
  root "statuses#index"
  resources :statuses, only: [:index, :create]
end
