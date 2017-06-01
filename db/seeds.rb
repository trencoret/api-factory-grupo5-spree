# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Inicial
# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)




# Despues
Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
Spree::Product.delete_all
Spree::Variant.delete_all



tax_category = Spree::TaxCategory.create(name: 'IVA',is_default: true)
tax_category.save

tax_rate = Spree::TaxRate.create(amount: 0.19, tax_category_id: 1, included_in_price: true)
tax_rate.save

product1 = Spree::Product.create(sku: "5", cost_currency: "CLP", name: "Yogur", description: "Este es un yogurt", available_on: Time.now, meta_keywords: "Yogur", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 1000)
#path = 'public/spree/products/20/product/cacao.jpeg'
#image = Spree::Image.create(attachment: File.open(path), viewable: product1.master, viewable_id: product1.id, viewable_type: 'Spree::Variant', attachment_file_name: "cacao.jpeg" , type: "Spree::Image")
#image.save
product1.save

product2 = Spree::Product.create(sku: "11", cost_currency: "CLP", name: "Margarina", description: "Esta es la mejor Margarina, excelente para el pan", available_on: Time.now, meta_keywords: "Margarina", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 1000)
product2.save

product3 = Spree::Product.create(sku: "17", cost_currency: "CLP", name: "Cereal de Arroz", description: "Un cereal muy nutritivo", available_on: Time.now, meta_keywords: "Cereal de Arroz", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 1000)
product3.save

product4 = Spree::Product.create(sku: "56", cost_currency: "CLP", name: "Hamburguesa de Pollo", description: "No se recomienda, mejor la de carne", available_on: Time.now, meta_keywords: "Hamburguesa", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 1000)
product4.save

# TODO: Cambiar el precio de venta de los Productos.