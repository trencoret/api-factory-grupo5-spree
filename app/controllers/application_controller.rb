require "http"

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :getStockProducto
  helper_method :crearBoleta
  helper_method :compraOnline
  

  #@url = 'http://localhost:3000/products/5'
  # puts "Esta es la url"
  # puts @url

  def getStockProducto(sku)
    url = 'http://localhost:3000/'
    carpeta = 'products/'
    url_final = url + carpeta + sku.to_s
    # puts 'URL FINAL:'
    # puts url_final
    #stock = HTTP.get(url_final).parse['stock']
    stock = 10
    return stock
  end

  def crearBoleta(id,cliente,precio, cantidad)
    url = 'http://localhost:3000/'
    url_final = url + 'api/boleta' 
    #Json: #proveedor: id, 
    #Falta ingresarle los params
    
    response = HTTP.headers(:accept => "application/json").put(url_final, :json => { :proovedor => id, :client => cliente, :precio => precio, :cantidad => cantidad})
    #end	
    
    resultadoEnJson = JSON.parse(response)
    return resultadoEnJson
  end

end
