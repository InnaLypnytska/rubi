# catalog.rb
class Catalog
  def initialize
    @products = []  # Інстансна змінна для зберігання списку товарів
  end

  # Метод для додавання нового товару
  def add_product(product)
    @products << product
    puts "Товар '#{product}' успішно додано до каталогу."
  end

  # Метод для виведення списку товарів
  def display_products
    if @products.empty?
      puts "Каталог порожній."
    else
      puts "Список товарів у каталозі:"
      @products.each { |product| puts "- #{product}" }
    end
  end
end

# main.rb
require_relative 'catalog'

# Демо-програма
catalog = Catalog.new
catalog.add_product("Ноутбук")
catalog.add_product("Смартфон")
catalog.add_product("Планшет")

catalog.display_products
