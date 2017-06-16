# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# # Inicial
# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)




# Despues
# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
# Spree::Product.delete_all
# Spree::Variant.delete_all



# tax_category = Spree::TaxCategory.create(name: 'IVA',is_default: true)
# tax_category.save

# tax_rate = Spree::TaxRate.create(amount: 0.19, tax_category_id: 1, included_in_price: true)
# tax_rate.save

# product1 = Spree::Product.create(sku: "5", cost_currency: "CLP", name: "Yogurt", description: "Yogurt del sur. La magia está en el color", available_on: Time.now, meta_keywords: "Yogur", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 445)
#path = 'public/spree/products/20/product/cacao.jpeg'
#image = Spree::Image.create(attachment: File.open(path), viewable: product1.master, viewable_id: product1.id, viewable_type: 'Spree::Variant', attachment_file_name: "cacao.jpeg" , type: "Spree::Image")
#image.save
# product1.save
path = 'app/assets/images/'

product = Spree::Product.find_by(name: "Yogur")
puts product
Spree::Image.create(:attachment => File.open(path+'yogur.jpg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Margarina")
puts product
Spree::Image.create(:attachment => File.open(path+'margarina.jpg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Cereal de Arroz")
puts product
Spree::Image.create(:attachment => File.open(path+'arroz.png'), :viewable => product.master)

product = Spree::Product.find_by(name: "Hamburguesa de Pollo")
puts product
Spree::Image.create(:attachment => File.open(path+'pollo.jpeg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Maiz")
puts product
Spree::Image.create(:attachment => File.open(path+'maiz.jpg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Leche")
puts product
Spree::Image.create(:attachment => File.open(path+'leche.jpg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Carne")
puts product
Spree::Image.create(:attachment => File.open(path+'carne.jpeg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Avena")
puts product
Spree::Image.create(:attachment => File.open(path+'avena.jpg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Mantequilla")
puts product
Spree::Image.create(:attachment => File.open(path+'mantequilla.jpeg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Azucar")
puts product
Spree::Image.create(:attachment => File.open(path+'azucar.jpg'), :viewable => product.master)

product = Spree::Product.find_by(name: "Harina Integral")
puts product
Spree::Image.create(:attachment => File.open(path+'harina.jpg'), :viewable => product.master)

# product2 = Spree::Product.create(sku: "11", cost_currency: "CLP", name: "Margarina", description: "Esta es la mejor Margarina, excelente para el pan", available_on: Time.now, meta_keywords: "Margarina", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 255)
# product2.save

# product3 = Spree::Product.create(sku: "17", cost_currency: "CLP", name: "Cereal de Arroz", description: "Un cereal muy nutritivo. Made in China", available_on: Time.now, meta_keywords: "Cereal de Arroz", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 830)
# product3.save

# product4 = Spree::Product.create(sku: "56", cost_currency: "CLP", name: "Hamburguesa de Pollo", description: "No se recomienda, mejor la de carne.", available_on: Time.now, meta_keywords: "Hamburguesa", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 500)
# product4.save

# product5 = Spree::Product.create(sku: "3", cost_currency: "CLP", name: "Maiz", description: "Pío Pío. MMmmmhhhh", available_on: Time.now, meta_keywords: "Maiz", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 120)
# product5.save

# product6 = Spree::Product.create(sku: "7", cost_currency: "CLP", name: "Leche", description: "Yo tomo leche", available_on: Time.now, meta_keywords: "Leche", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 295)
# product6.save

# product7 = Spree::Product.create(sku: "9", cost_currency: "CLP", name: " Carne", description: "Asado", available_on: Time.now, meta_keywords: "Carne", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 355)
# product7.save

# product8 = Spree::Product.create(sku: "15", cost_currency: "CLP", name: "Avena", description: "Esto comen los niños malos" , available_on: Time.now, meta_keywords: "Avena", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 285)
# product8.save

# product9 = Spree::Product.create(sku: "22", cost_currency: "CLP", name: "Mantequilla", description: "Pan para esto no hay?", available_on: Time.now, meta_keywords: "Mantequilla", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 345)
# product9.save

# product10 = Spree::Product.create(sku: "25", cost_currency: "CLP", name: "Azucar", description: "Manjar Colún", available_on: Time.now, meta_keywords: "Azucar", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 95)
# product10.save

# product11 = Spree::Product.create(sku: "52", cost_currency: "CLP", name: "Harina Integral", description: "Comida para pajaros" , available_on: Time.now, meta_keywords: "Harina Integral", tax_category_id: 1, shipping_category_id: 1, promotionable: false, price: 460)
# product11.save



# TODO: Cambiar el precio de venta de los Productos.
