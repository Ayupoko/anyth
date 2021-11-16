Rails.application.routes.draw do

devise_for :admins, controllers: {
  sessions: 'admins/sessions'
}

devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
}  



  namespace :admin do
    get 'homes/top'
    resources :spaces
    resources :users
  end
  
  
# public_user
  root to: 'homes#top'
  resources :users
  get 'homes/about'
end
