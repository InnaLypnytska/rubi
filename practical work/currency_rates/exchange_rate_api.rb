require 'net/http'
require 'json'
require 'csv'

class ExchangeRateAPI
  API_URL = 'https://open.er-api.com/v6/latest'

  def initialize(base_currency)
    @base_currency = base_currency
  end

  def fetch_rates
    url = URI("#{API_URL}/#{@base_currency}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    if data['result'] == 'success'
      data['rates']
    else
      raise "Помилка API: #{data['error-type']}"
    end
  end

  def save_to_csv(rates, file_name)
    CSV.open(file_name, 'w', write_headers: true, headers: ['Валюта', 'Курс']) do |csv|
      rates.each do |currency, rate|
        csv << [currency, rate]
      end
    end
  end
end

# Приклад використання
begin
  base_currency = 'USD'
  api = ExchangeRateAPI.new(base_currency)

  rates = api.fetch_rates
  api.save_to_csv(rates, 'exchange_rates.csv')

  puts "Курси валют збережено у файл exchange_rates.csv"
rescue StandardError => e
  puts "Виникла помилка: #{e.message}"
end
