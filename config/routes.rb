Rails.application.routes.draw do
  get 'userevents/create'
  get '/events/have-match' => 'events#have_match'
	root 'dashboards#index'
	
	post '/events/myevents' => 'events#myevents'
  post '/events/all' => 'events#allevents'

devise_for :users, :controllers => { :omniauth_callbacks => "callbacks",:registrations => "registrations"  }
	
	resources :events

  post '/events/pin-event' => 'events#pin_event'
  
  resources :users
  post "/userevents" => "userevents#create"
  get '/users/:id/events' => 'users#my_events'  
  get '/events/:id/pin_event' => 'events#pin_event'
  get '/events/:id/unpin_event' => 'events#unpin_event'
  post "/events/:event_id/users/:user_id/tinder/:selection" => 'users#tinder'


  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end  
  end
  post "/users/:id/interested_in" => 'users#interested_in'
  post '/events/tinder_logic' => 'events#tinder_logic'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

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
