Rails.application.routes.draw do
  resources :people
  resources :programs do
    resources :teachers, controller: 'programs/teachers'
    resources :roles, controller: 'programs/roles' do
      resources :people, controller: 'programs/roles/people'
    end
  end
  resources :roles do
    resources :people, controller: 'roles/people'
  end

  root 'home#show'
end
