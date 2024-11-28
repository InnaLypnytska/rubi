class Dictionary
  attr_reader :words

  def initialize(words = {})
    @words = words
  end

  def +(other)
    merged_words = @words.merge(other.words)
    Dictionary.new(merged_words)
  end

  def to_s
    @words.to_s
  end
end

dict1 = Dictionary.new({ "apple" => "яблуко", "dog" => "собака" })
dict2 = Dictionary.new({ "cat" => "кіт", "dog" => "пес" })

result_dict = dict1 + dict2
puts result_dict  # Виведе {"apple"=>"яблуко", "dog"=>"пес", "cat"=>"кіт"}
