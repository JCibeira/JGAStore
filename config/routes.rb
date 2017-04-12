Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', home: 'home' }
	  
  get "registroapi", to: "home#showregisterAPI", as: 'registershow'
  post "registroapi",  to: "home#sendregisterAPI", as: 'registershowsend'

  get "perfil", to: "home#showPerfil", as: "showPerfil"

  get "prepurchase", to: "home#prepurchase", as: "prepurchase"

  root 'home#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
