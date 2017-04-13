class HomeController < ApplicationController
  def index
  	vars = request.query_parameters
  	if user_signed_in?  
  		if $carro == nil
  			$carro = []
  		end
  	else
  		$carro = nil
  	end

  	@products = JSON.parse(open("http://localhost:5000/product").read, {:symbolize_names => true})

  	if vars['action_do'] == "succesfull_register"
  		flash.now["success"] = "Registro exitoso, por favor inicie sesion"

  	elsif vars['action_do'] == "succesfull_add"
  		flash.now["success"] = "Producto agregado al carro exitosamente"

  	elsif vars['action_do'] == "succesfull_delete"
		flash.now["success"] = "Producto eliminado del carro exitosamente"
  	end	
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
  	redirect_to controller: 'home', action: 'index', action_do: "succesfull_register"
  end

  def showPerfil
  	render(:action => 'perfil')
  end

  def prepurchase
  	@data = []
  	if($carro.size != 0)
	  	uri = URI('http://localhost:5000/products')
		req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
		req.body = {ids: $carro}.to_json
		res = Net::HTTP.start(uri.hostname, uri.port) do |http|
			http.request(req)
		end
		@data = JSON.parse(res.body) #Aqui esta la respuesta del API
	end
  	render(:action => 'precompra')
  end
  
  def showProduct
	product_id = params[:id]
	@product = JSON.parse(open("http://localhost:5000/product/"+product_id).read, {:symbolize_names => true})
  	render(:action => 'product')
  end


  def addCarro
  	$carro.push((params[:id]).to_i)

  	redirect_to controller: 'home', action: 'index', action_do: "succesfull_add"

  end

  def deleteCarro
  	$carro.delete((params[:id]).to_i)

  	redirect_to controller: 'home', action: 'index', action_do: "succesfull_delete"

  end

end
