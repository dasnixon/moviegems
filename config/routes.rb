Moviegems::Application.routes.draw do
  devise_for :users
  scope '/', controller: :home do
    get :about
    get :contact
  end
  scope '/admin', controller: :admin do
    get :panel
    post 'accept_director/:user_id', action: :accept_director
    post 'decline_director/:user_id', action: :decline_director
  end
  root 'home#index'
end
