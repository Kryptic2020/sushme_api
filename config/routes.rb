Rails.application.routes.draw do
 
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "users#index" 
  #get "/", to: "users#index", as:"index"
  scope '/api' do
    scope '/products' do
      get '/index', to: "products#index"
      get '/top-seller', to: "products#top_seller"
      get '/show/:id', to: "products#show"
      delete '/:id', to: "products#destroy"
      post '/create', to: "products#create"
      put '/update', to: "products#update"
    end
    scope '/categories' do
      get '/index', to: 'categories#index'
      get '/:id', to: 'categories#show'
      post '/create', to: 'categories#create'
      delete '/:id', to: 'categories#destroy'
      put '/update', to: 'categories#update'
    end
    scope '/auth' do
      post "/current-user", to: "users#show"
      post "/sign-up", to: "users#create"
      post "/sign-in", to: "users#sign_in"
      put "/update", to: "users#update"
      post "/forgot-pass", to: "users#forgot_pass"
      post "/reset-pass", to: "users#reset_pass"
    end
    scope '/order-item' do
      get '/:id', to: 'order_item#show'
    end
    scope '/basket' do
      get '/:id', to: 'order#show'
    end

  end
end
