require 'minitest/autorun'
require 'net/http'
require 'json'
require 'csv'
require_relative 'exchange_rate_api'

class TestExchangeRateAPI < Minitest::Test
  def setup
    @base_currency = 'USD'
    @api = ExchangeRateAPI.new(@base_currency)
    @test_file = 'test_rates.csv'
  end

  def test_fetch_rates
    rates = @api.fetch_rates
    assert rates.is_a?(Hash), "Результат повинен бути хешем"
    assert rates.keys.include?('EUR'), "Повинна бути інформація про EUR"
    assert rates['EUR'].is_a?(Numeric), "Курс повинен бути числом"
  end

  def test_save_to_csv
    rates = { 'EUR' => 0.85, 'GBP' => 0.75 }
    @api.save_to_csv(rates, @test_file)

    assert File.exist?(@test_file), "CSV файл повинен бути створений"

    content = CSV.read(@test_file, headers: true)
    assert_equal 2, content.size, "У файлі повинно бути 2 рядки"
    assert_equal ['Валюта', 'Курс'], content.headers, "Заголовки CSV мають відповідати"
    assert_equal ['EUR', '0.85'], content[0], "Значення у першому рядку повинні відповідати"
  ensure
    File.delete(@test_file) if File.exist?(@test_file)
  end
end
