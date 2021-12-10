Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "users#index", as:"index"
  scope '/api' do
    scope '/auth' do
      post "/current-user", to: "users#show"
      post "/sign-up", to: "users#create"
      post "/sign-in", to: "users#sign_in"
      put "/update", to: "users#update"
      post "/forgot-pass", to: "users#forgot_pass"
      post "/reset-pass", to: "users#reset_pass"
    end

  end
end
