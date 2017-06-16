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
    url = 'http://integra17-5.ing.puc.cl/'
    carpeta = 'products/'
    url_final = url + carpeta
    # puts 'URL FINAL:'
    # puts url_final
    stock = 0
    response = HTTP.get(url_final)
    responseP = JSON.parse response
    responseP.each do |hash|
      if hash['sku'] == sku
        stock = hash['stock']
        break
      end
    end
    # stock = 10
    return stock
  end

  def crearBoleta(id,cliente,precio, cantidad, sku)
    url = 'http://integra17-5.ing.puc.cl/'
    url_final = url + 'api/boleta'
    #Json: #proveedor: id,
    #Falta ingresarle los params

    response = HTTP.headers(:accept => "application/json").put(url_final, :json => { :id => id, :cliente => cliente, :precio => precio, :cantidad => cantidad, :sku => sku})
    #end
    puts "AAAAAAAAAAAAAAAA"
    puts response
    resultadoEnJson = JSON.parse(response)
    return resultadoEnJson
  end

  private

  def get_stock_by_sku(sku)
        stock_final = 0
        response = ""
        @almacenes.each do |almacen|
          # No busca en despacho
          break if almacen["despacho"]
          data = "GET#{almacen["_id"]}"
          loop do
            response = HTTP.auth(generate_header(data)).headers(:accept => "application/json").get(Rails.configuration.base_route_bodega + "skusWithStock?almacenId=" + almacen["_id"])
            break if response.code == 200
          end
          products = JSON.parse response.to_s
          products.each do |product|
            # Sku viene en id de producto
              if product["_id"] == sku
                  stock_final += product["total"]
              end
          end
        end
        # Se resta lo reservado
        # Si queda en negativo, se setea en cero.
        stock_final - producto.stock_reservado > 0 ? (stock_final - producto.stock_reservado) : 0
    end

end
