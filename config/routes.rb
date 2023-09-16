Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'payroll_report/index'
  # get 'payroll_report/new'
  # get 'payroll_report/create'

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :payroll_report, only: [:index, :new, :create]
    end
  end
end
