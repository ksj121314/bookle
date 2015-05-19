Bookle::Application.routes.draw do
  resources :carts

  get "users/signup"
  post "users/signup_complete"
  get "users/login"
  post "users/login_complete"
  get "users/logout_complete"
  get "users/purchase_list"
  get "book_reviews/posts"
  get "book_reviews/show/:id" => "book_reviews#show"
  get "book_reviews/write/:id" => 'book_reviews#write'
  post "book_reviews/write_complete"
  get "book_reviews/edit/:id" => 'book_reviews#edit'
  post "book_reviews/edit_complete"
  get "book_reviews/delete_complete/:id" => 'book_reviews#delete_complete'
  post "book_reviews/write_comment_complete"
  get "book_reviews/delete_comment_complete/:id" => 'book_reviews#delete_comment_complete'
  root "books#posts"
  get "/:category" => "books#posts_category"
  get "books/show/:id" => 'books#show'
  get "books/write"
  post "books/write_complete"
  get "books/edit/:id" => 'books#edit'
  post "books/edit_complete"
  get "books/delete_complete/:id" => 'books#delete_complete'
  get "books/purchase_complete/:id" => 'books#purchase_complete'
  get "books/purchase_list"
  get "carts/create"
  
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
