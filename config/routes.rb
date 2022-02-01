Rails.application.routes.draw do
  resources :people
  resources :programs do
    resources :teachers, controller: 'program/teachers'
    resources :roles, controller: 'program/roles' do
      resources :people, controller: 'program/role/people'
    end
  end
  resources :roles do
    resources :people, controller: 'role/people'
  end

  root 'people#index'
end
