ChessCamp::Application.routes.draw do
  get "users/edit"
  get "users/index"
  get "users/new"
  get "users/show"
  get "registrations/edit"
  get "registrations/index"
  get "registrations/new"
  get "registrations/show"
  get "locations/edit"
  get "locations/index"
  get "locations/new"
  get "locations/show"
  get "students/edit"
  get "students/index"
  get "students/new"
  get "students/show"
  get "families/edit"
  get "families/index"
  get "families/new"
  get "families/show"
  # generated routes
  resources :curriculums
  resources :instructors
  resources :camps
  resources :students
  resources :families
  resources :locations
  resources :users
  resources :sessions
  resources :registrations

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  
  # params begin with a :
  get 'camp/:id/home_payment_report' => 'home#home_payment_report', as: :dashboard_payment_report
  get 'camp/:id/camp_payment_report' => 'camps#camp_payment_report', as: :camp_payment_report
  get 'camp/:id/registered_students' => 'home#registered_students', as: :registered_students
  get 'family/:id/family_payment_students' => 'families#family_payment_students', as: :all_family_payments
  get 'past_camp_payments' => 'home#past_camp_payments', as: :past_camp_payments
  # set the root url
  root to: 'home#index'

end
