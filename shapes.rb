class Figure
  def area
    raise NotImplementedError, "Метод 'area' потрібно реалізувати у підкласі"
  end
end

class Square < Figure
  def initialize(side)
    @side = side
  end

  def area
    @side ** 2
  end
end

class Triangle < Figure
  def initialize(base, height)
    @base = base
    @height = height
  end

  def area
    0.5 * @base * @height
  end
end

square = Square.new(4)
puts "Площа квадрата: #{square.area}"  # Виведе 16

triangle = Triangle.new(5, 10)
puts "Площа трикутника: #{triangle.area}"  # Виведе 25.0
