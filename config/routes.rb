ChessCamp::Application.routes.draw do
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

  # semi-static routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  # set the root url
  root to: 'home#index'

end
