Rails.application.routes.draw do
  get 'comments/to/:post_id' =>'comments#new', :as => 'new_comment_from_post'
  resources :comments
  resources :posts
  resources :profiles
  devise_for :users , :controllers => {:registrations => "registrations"}
  resources :users
  get 'friendships' => 'friendships#index', :as => 'friendships'
  post 'friendships/:id/accept' => 'friendships#accept', :as => 'friendship_accept'
  post 'friendships/:id/declined' => 'friendships#remove_friend', :as => 'friendship_declined'
  post 'friendships/:id/remove_request' => 'friendships#remove_friend', :as => 'friendship_remove_request'
  post 'friendships/:id/remove_friend' => 'friendships#remove_friend', :as => 'friendship_remove_friend'
  post 'friendships/:id/send_request' => 'friendships#send_request', :as => 'friendship_send_request'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'profile/:id' => 'profiles#wall', :as => 'wall_profile'
  post 'profile/:post_id/like' => 'profiles#like', :as => 'like_post'
  # You can have the root of your site routed with "root"
  root 'profiles#wall'

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
