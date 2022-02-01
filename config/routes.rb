Rails.application.routes.draw do
  resources :people
  resources :programs do
    resources :teachers, controller: 'programs/teachers'
    resources :roles, controller: 'programs/roles' do
      resources :people, controller: 'programs/roles/people'
    end
  end
  resources :roles do
    post :sort, on: :collection
    resources :people, controller: 'roles/people' do
      post :sort, on: :collection
    end
  end

  root 'home#show'
end
