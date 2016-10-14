Rails.application.routes.draw do 


  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  root 'pages#home'

  resources :users do
    resources :invs do
      resources :inv_trans
      resources :images
      delete "delete_inv", to: "invs#destroy"
    end
    post 'invs/get_month_of_year_transactions', contraints: {format: 'json'}
  end

  post "post_inv", to: "invs#create"
  post "post_inv_tran", to: "inv_trans#create"
  patch "update_inv_image", to: "invs#save_image"
end
