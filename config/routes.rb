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
    resources :reservations, only: [:index, :show]
  end
  
  
# public_user
  get "/homes/reject" => "homes#reject", as: 'homes_reject'
  get "/users/quit" => "users#quit", as: 'users_quit'
  patch "/users/out" => "users#out", as: 'users_out' 
  root to: 'homes#top'
  resources :users, except: [:edit]
  resources :reservations # , except: [:show]
  post "/reservations/confirm" => "reservations#confirm", as: 'reservations_confirm'
  get 'homes/about'
end
