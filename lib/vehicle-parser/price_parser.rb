class PriceParser
  
  def initialize(hash)
    @price=hash[:price]
    @year=hash[:year]
    @skip_keywords=hash[:skip_keywords]
  end
  
  def get_price
    return 0 if @price.blank?
    return 0 if !@price[/call|coming|over|llama/i].nil? && (@skip_keywords==false || @skip_keywords.blank?)
    return 0 if !@price[/msrp/i].nil? && !([] << Time.new.year << Time.new.year.next).include?(@year)
    return 0 if !PhoneParser.parse_phone(@price).nil?
    parse_price
  end
  
  def parse_price
    @price=@price.gsub(Regexp.new("\\b#{@year.to_s}\\b|\\b#{@year.to_s.last(2)}\\b"),"")
    parsed_price=parse_to_float(@price.strip[/\d[\d\,\.]+/]) if !@price[/\d[\d\,\.]+/].nil?
    parsed_price ||=0
  end

  def parse_to_float(num)
    num.delete(",").delete("$").to_f
   end
end
