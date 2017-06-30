Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'

  get '/locale/set', to: 'locale#set'

  # non-restful checkout stuff
  patch '/checkout/update/:state', to: 'checkout#update', as: :update_checkout
  get '/checkout/:state', to: 'checkout#edit', as: :checkout_state
  get '/checkout', to: 'checkout#edit', as: :checkout

  get '/orders/populate', to: 'orders#populate_redirect'

  resources :orders, except: [:index, :new, :create, :destroy] do
    post :populate, on: :collection
  end

  get '/cart', to: 'orders#edit', as: :cart
  patch '/cart', to: 'orders#update', as: :update_cart
  put '/cart/empty', to: 'orders#empty', as: :empty_cart

  # route globbing for pretty nested taxon and product paths
  get '/t/*id', to: 'taxons#show', as: :nested_taxons

  get '/unauthorized', to: 'home#unauthorized', as: :unauthorized
  get '/content/cvv', to: 'content#cvv', as: :cvv
  get '/content/*path', to: 'content#show', as: :content
  get '/cart_link', to: 'store#cart_link', as: :cart_link

  get '/expired', to: 'orders#expired'
  get '/notfound', to: 'orders#error'

end
