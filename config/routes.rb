Rails.application.routes.draw do
  root "products#catalog"
  resource :session
  resources :passwords, param: :token
  resources :categories
  resources :products
  resources :users, only: %i[new create]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "catalog", to: "products#catalog"

  get "catalog/products/:id", to: "products#catalog_show", as: :catalog_product

  get "cart", to: "carts#show", as: :cart
  post "cart/items", to: "carts#add", as: :cart_items
  delete "cart/items/:product_id", to: "carts#remove", as: :remove_cart_item
  get    "cart/items/:product_id", to: "carts#remove"
  patch  "cart/items/:product_id/increase", to: "carts#increase", as: :increase_cart_item
  patch  "cart/items/:product_id/decrease", to: "carts#decrease", as: :decrease_cart_item

  get "checkout", to: "checkouts#show"
  post "checkout", to: "checkouts#create"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
