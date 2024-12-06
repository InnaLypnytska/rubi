def infix_to_rpn(expression)
  precedence = { '+' => 1, '-' => 1, '*' => 2, '/' => 2, '^' => 3 }
  associativity = { '+' => 'L', '-' => 'L', '*' => 'L', '/' => 'L', '^' => 'R' }
  output = []
  operators = []

  # Розбиваємо вираз на токени (підтримує багатозначні числа і пробіли)
  tokens = expression.gsub('(', ' ( ').gsub(')', ' ) ').split

  tokens.each do |token|
    if token.match?(/\d+/) # Операнд
      output << token
    elsif precedence.key?(token) # Оператор
      while !operators.empty? && operators.last != '(' &&
            (precedence[operators.last] > precedence[token] ||
            (precedence[operators.last] == precedence[token] && associativity[token] == 'L'))
        output << operators.pop
      end
      operators << token
    elsif token == '('
      operators << token
    elsif token == ')'
      while !operators.empty? && operators.last != '('
        output << operators.pop
      end
      operators.pop # Видаляємо '('
    end
  end

  # Додаємо всі залишкові оператори
  output += operators.reverse
  output.join(' ')
end

# Приклад використання
example_expression = "2 + 1 * 4"
rpn_output = infix_to_rpn(example_expression)
puts rpn_output
