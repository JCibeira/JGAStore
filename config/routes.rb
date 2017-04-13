Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', home: 'home' }
	  
  get "registroapi", to: "home#showregisterAPI", as: 'registershow'
  post "registroapi",  to: "home#sendregisterAPI", as: 'registershowsend'

  get "perfil", to: "home#showPerfil", as: "showPerfil"

  get "prepurchase", to: "home#prepurchase", as: "prepurchase"

  get "producto/:id", to: "home#showProduct", as: "producto"

  post "producto/:id", to: "home#addCarro", as: "addcar"
  delete "producto/:id", to: "home#deleteCarro", as: "deletecar"


  post "addProducto", to: "home#addProducto", as: "addProducto"

  get "categoria/:categoria", to: "home#showCat", as: "showCat"

  get "orden/alfabeticamente/:id", to: "home#showAlfa", as: "showAlfabeticamente"

  get "orden/precio/:id", to: "home#showPrec", as: "showPrecio"

  root 'home#index', as: "root"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
