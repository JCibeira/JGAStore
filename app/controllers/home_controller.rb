class HomeController < ApplicationController
  def index
  	@products = JSON.parse(open("http://localhost:5000/product").read, {:symbolize_names => true})
  end
end
