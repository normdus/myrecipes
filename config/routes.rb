Rails.application.routes.draw do
  root "pages#home"
  
  get '/home', to: 'pages#home'
  
 
  # likes route added here
  resources :recipes do
    member do
      post 'like'
    end
  end
  
  # ***** Chefs Routes *****
  # want a diff route for new... 
  resources :chefs, except: [:new]
  # create the route to register using the same for home above
  get '/register', to: 'chefs#new'
  # ***** end of Chefs Routes *****
  
  # ***** Authentication ****
  #   login -> new session
  #   logout -> close session
  #   post login -> create session
  get '/login', to: "logins#new"  # controller - new action #
  post '/login', to: "logins#create"
  get '/logout', to: "logins#destroy"
  
end
