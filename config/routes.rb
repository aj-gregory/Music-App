MusicApp::Application.routes.draw do
  resources :users, :only => [:new, :create, :show]
  resource :session, :only => [:new, :create, :destroy]

  resources :bands do
    resources :albums, :only => [:new, :create, :index]
  end

  resources :albums, :except => [:new, :create, :index] do
    resources :tracks, :only => [:new, :create, :index]
  end

  resources :tracks, :except => [:new, :create, :index] do
    resources :notes, :only => [:create]
  end

  resources :notes, :only => [:destroy]
end
