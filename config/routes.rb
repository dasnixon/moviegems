Moviegems::Application.routes.draw do
  devise_for :users
  scope '/', controller: :home do
    get :about
    get :contact
  end
  scope '/admin', controller: :admin do
    get :panel, as: :admin_panel
    post 'director_action/:user_id', action: :director_action
  end
  scope '/director', controller: :director do
    get :panel, as: :director_panel
    post 'request_for_director/:user_id', action: :request_for_director
  end
  root 'home#index'
end
