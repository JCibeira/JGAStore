class HomeController < ApplicationController
  def index
  	@products = JSON.parse(open("http://localhost:5000/product").read, {:symbolize_names => true})
  end

  def showregisterAPI
  	render(:action => 'registro')
  end


  def sendregisterAPI
  	#Realizo la peticion al API con los parametros introducidos
  	uri = URI('http://localhost:5000/login')
	req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
	req.body = {email: params[:email], password: params[:password]}.to_json
	res = Net::HTTP.start(uri.hostname, uri.port) do |http|
		http.request(req)
	end
	data = JSON.parse(res.body) #Aqui esta la respuesta del API
	if(data['login_value']) #Se logeo correctamente
		hay_email = User.find_by_email(data['email'])
		if(!hay_email) #El usuario no existe
			@user = User.create(:email => data['email'], :password => data['password'], :password_confirmation => data['password'], 
								:nombre => data['nombre'], :apellido => data['apellido'], :username => data['username'],
								:fotoPerfil => data["fotoPerfil"], :genero => data['genero'], 
								:telefono => data['telefono'])
		end
	end
  	redirect_to controller: 'home', action: 'index'
  end

  def showPerfil
  	render(:action => 'perfil')
  end
  	
end
