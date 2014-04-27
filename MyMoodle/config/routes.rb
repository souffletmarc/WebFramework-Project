MyMoodle::Application.routes.draw do
  resources :semesters

  resources :roles

  resources :grades

  resources :courses

  get "session/new"
  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root :to=>'sessions#new'
  # Example of regular route:
  get '/profil/:id', to: 'users#show', as: 'profil'
  get '/addcourse/:id', to: 'courses#add_user', as: 'addusertocourse'
  get '/delcourse/:id', to: 'courses#del_user', as: 'delusertocourse'


  match 'signin',  :to => 'sessions#new', :via => [:get]
  match 'signout', :to => 'sessions#destroy', :via => [:get] 
  match 'sessions', :to => 'sessions#create', :via => [:post]   

  match 'signup', :to => 'users#new', :via => [:get] 

  #match 'profil',  :to => 'users#show', :via => [:get]
  match 'students_modules',  :to => 'courses#students_courses', :via => [:get]
  match 'lecturers_modules', :to => 'courses#lecturers_courses', :via => [:get] 
  match 'admins_modules',  :to => 'courses#admins_courses', :via => [:get]
  match 'lecturers', :to => 'users#lecturers_index', :via => [:get]
  match 'students',  :to => 'users#students_index', :via => [:get]

  match 'search',  :to => 'users#search', :via => [:get]
  match 'addmarktouser', :to => 'courses#add_mark', :via => [:post]
  match 'updatemarktouser', :to => 'courses#update_mark', :via => [:post]

  match 'course_adduser',  :to => 'courses#add_user', :via => [:get]
  match 'new_lecturer',  :to => 'users#new_lecturer', :via => [:get]
  match 'new_student',  :to => 'users#new_student', :via => [:get]

  match 'addusertocoursepost',  :to => 'courses#add_user', :via => [:post]

  match 'admins_semester',  :to => 'semesters#index', :via => [:get]



  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
