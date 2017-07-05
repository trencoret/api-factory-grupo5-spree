require "http"

module Spree
  class OrdersController < Spree::StoreController
    helper_method :pagoWeb

    before_action :check_authorization
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/products', 'spree/orders'


    respond_to :html

    before_action :assign_order_with_lock, only: :update
    skip_before_action :verify_authenticity_token, only: [:populate]

    def show
      @order = Order.includes(line_items: [variant: [:option_values, :images, :product]], bill_address: :state, ship_address: :state).find_by_number!(params[:id])
    end

    def update
      if @order.contents.update_cart(order_params)
        respond_with(@order) do |format|
          format.html do
            if params.has_key?(:checkout)
              @order.next if @order.cart?
              redirect_to checkout_state_path(@order.checkout_steps.first)
            else
              redirect_to cart_path
            end
          end
        end
      else
        respond_with(@order)
      end
    end

    # Shows the current incomplete order from the session
    def edit
      @order = current_order || Order.incomplete.
                                  includes(line_items: [variant: [:images, :option_values, :product]]).
                                  find_or_initialize_by(guest_token: cookies.signed[:guest_token])
      associate_user
    end

    # Adds a new item to the order (creating a new order if none already exists)
    def populate
      order    = current_order(create_order_if_necessary: true)
      variant  = Spree::Variant.find(params[:variant_id])
      quantity = params[:quantity].to_i
      options  = params[:options] || {}
      direccion = params[:direccion]
      cliente = params[:name]
      code = params[:code]
      puts "AAAAAAAAAAAAA"
      puts code
      sku = params[:sku]
      price = params[:price].to_i
      #TODO: Cambiar el precio de venta de los skus


      # respuesta = revisar_codigo(code)
      # if respuesta.code == 200
      #   promos = respuesta.parse
      #   promos.each do |promo|
      #     price = promo["precio"]
      #   end
      # end

      # 2,147,483,647 is crazy. See issue #2695.
      if quantity.between?(1, 2_147_483_647)
        order.contents.add(variant, quantity, options)
        order.update_line_item_prices!
        order.create_tax_charge!
        order.update_with_updater!
      else
        error = Spree.t(:please_enter_reasonable_quantity)
      end

      if error
        flash[:error] = error
        redirect_back_or_default(spree.root_path)
      else

        precio_final = price*quantity
        if code != "Ingrese código de promoción" && code != nil && code != ""
          oferta = HTTP.headers(:accept => "application/json").get("http://localhost:3000/promo",
            :json => { :code => code, :sku => sku})
          ofertaP = JSON.parse oferta
          if ofertaP["existe"]
            precio_final = ofertaP["precio"].to_f*quantity
          elsif oferta.code == 401
            redirect_to "http://stark-garden-87198.herokuapp.com/expired"
            return
          elsif oferta.code == 404
            redirect_to "http://stark-garden-87198.herokuapp.com/notfound"
            return
          end
        end

        # Asi estaba antes, ahora para probar comprando de una

        # respond_with(order) do |format|
        #   format.html { redirect_to cart_path }
        # end



        #   #DEV: 590baa00d6b4ec0004902466
    #   #PROD: 5910c0910e42840004f6e684

      respuesta = crearBoleta("5910c0910e42840004f6e684", cliente, precio_final, quantity, sku)
      puts 'pago respuesta'
      puts respuesta["_id"]

      #Cuando este arriba
      url_ok = "http%3A%2F%2Fintegra17-5.ing.puc.cl/tienda/ok/"+respuesta['_id'].to_s
      # Ahora para probar con local host
      # url_ok = 'http%3A%2F%2Flocalhost:3000/tienda/ok/'+respuesta['_id']


      # Cuando este arriba
      url_fail = "http%3A%2F%2Fintegra17-5.ing.puc.cl/tienda/fail/"+respuesta['_id'].to_s
      # Ahora para probar
      # url_fail = 'http%3A%2F%2Flocalhost:3000/tienda/fail/'
      url = "https://integracion-2017-prod.herokuapp.com/web/pagoenlinea?callbackUrl="+url_ok+"&cancelUrl="+url_fail+"+&boletaId="+respuesta['_id'].to_s

      redirect_to url
      end

    end


    def revisar_codigo(code)
      route = "http://integra17-5.ing.puc.cl/promo/" + code
      response =  HTTP.get(route )
    end

    def new_price

    end
    def expired
      Rails.logger.debug "Entro a expired"
    end

    def notfound
      Rails.logger.debug "Entro a notfound"
    end

    def empty
      if @order = current_order
        @order.empty!
      end

      redirect_to spree.cart_path
    end

    def accurate_title
      if @order && @order.completed?
        Spree.t(:order_number, :number => @order.number)
      else
        Spree.t(:shopping_cart)
      end
    end

    def check_authorization
      order = Spree::Order.find_by_number(params[:id]) || current_order

      if order
        authorize! :edit, order, cookies.signed[:guest_token]
      else
        authorize! :create, Spree::Order
      end
    end



    private

      def order_params
        if params[:order]
          params[:order].permit(*permitted_order_attributes)
        else
          {}
        end
      end

      def assign_order_with_lock
        @order = current_order(lock: true)
        unless @order
          flash[:error] = Spree.t(:order_not_found)
          redirect_to root_path and return
        end
      end
  end

end
