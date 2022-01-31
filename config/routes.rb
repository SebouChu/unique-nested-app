Rails.application.routes.draw do
  resources :programs
  resources :people

  root 'people#index'
end
