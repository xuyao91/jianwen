Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "news#index"
  resources :news	do 
  	get :sync, on: :collection
  end	
  resources :users
end
