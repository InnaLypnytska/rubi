def valid_ipv4?(address)
  # Розділяємо строку на частини за крапками
  parts = address.split('.')
  # Перевіряємо, чи містить адреса рівно 4 частини
  return false unless parts.length == 4

  parts.all? do |part|
    # Перевіряємо, чи є кожна частина числом від 0 до 255 без ведучих нулів
    part.match?(/^\d+$/) && part.to_i.between?(0, 255) && part == part.to_i.to_s
  end
end

# Тести
puts valid_ipv4?("192.168.0.1")   # true
puts valid_ipv4?("255.255.255.255") # true
puts valid_ipv4?("256.0.0.1")     # false
puts valid_ipv4?("01.02.03.04")   # false
puts valid_ipv4?("192.168.1")     # false
puts valid_ipv4?("192.168..1")    # false
