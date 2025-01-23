Rails.application.routes.draw do
  get "dashboard", to: 'dashboard#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "home#index"
  resources :courses do
    resources :enrollments, only: [:new, :create]
    resources :subtopics
    resources :feedbacks
  end
  post 'users/mark_attendance', to: 'users#mark_attendance', as: 'mark_user_attendance'
  post 'create_user', to: 'users#create', as: 'create_user'
  get 'users', to: 'users#index'
  get 'portal_users', to: 'users#portal_users', as: 'portal_users'
  get 'courses/:course_id/users', to: 'courses#users', as: 'course_users'
  post 'save_daily_status', to: 'statuses#save_daily_status'
  get 'bi_weekly_feedback/:user_id', to: 'feedbacks#bi_weekly', as: 'bi_weekly_feedback'
  post 'bi_weekly_feedback/:user_id', to: 'feedbacks#create_bi_weekly', as: 'create_bi_weekly_feedback'
  get 'feedbacks/all', to: 'feedbacks#all_feedbacks', as: 'all_feedbacks'
  post 'feedbacks/export_to_csv', to: 'feedbacks#export_to_csv', as: 'export_feedbacks_to_csv', defaults: { format: :csv }
  
  resources :users, only: [:index, :new, :edit, :update, :destroy] do
    resources :statuses, only: [:index]
    resources :attendances, only: [:index]
  end
end
