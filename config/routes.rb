Moviegems::Application.routes.draw do
  devise_for :users
  scope '/admin', controller: :admin do
    get :panel
  end
  root 'home#index'
end
