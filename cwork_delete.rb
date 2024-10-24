# Метод для видалення всіх пробілів з рядка
def remove_spaces(str)
  str.delete(' ')
end

result = remove_spaces(" Привіт, світ! ")
puts "'#{result}'"  

result = remove_spaces("Ruby    is   fun!")
puts "'#{result}'"

result = remove_spaces("   Програмування    на   Ruby   ")
puts "'#{result}'"
