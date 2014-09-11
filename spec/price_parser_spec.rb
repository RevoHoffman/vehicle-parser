require 'spec_helper'

describe "Price Parser Specs" do
  it "should return the price if the price field doesn't contain any unallowed words" do
    PriceParser.new({:price=>"$10,500"}).get_price.should==10500
  end
  
  it "should return 0 if the price field contains the words 'call'" do
    PriceParser.new({:price=>"call for $10 discount"}).get_price.should==0
  end
  
  it "should return 0 if the price field contains the words 'call'" do
    PriceParser.new({:price=>"call for $10 discount"}).get_price.should==0
  end
  
  it "should return 0 if the price field contains the words 'coming'" do
    PriceParser.new({:price=>"Price coming!"}).get_price.should==0
  end
  
  it "should return 0 if the price field contains the words 'over'" do
    PriceParser.new({:price=>"All prices $1000 over our cost!"}).get_price.should==0
  end
  
  it "should return 0 if the price field contains the words 'llama'" do
    PriceParser.new({:price=>"llama hoy miso!"}).get_price.should==0
  end
  
  it "should return 0 if the price field contains the word 'MSRP' and the year isn't current or next year" do
    PriceParser.new({:price=>"MSRP $50,000",:year=>2005}).get_price.should==0
  end
  
  it "should return the price if the price field contains the word 'MSRP' and the year is current or next year" do
    PriceParser.new({:price=>"MSRP $50,000",:year=>Time.now.year+1}).get_price.should==50000
  end
  
  it "should return 0 if the price field is nil, empty or contains non-pricing data." do
    PriceParser.new({:price=>nil}).get_price.should==0
    PriceParser.new({:price=>""}).get_price.should==0
    PriceParser.new({:price=>"asdasdas"}).get_price.should==0
  end
  
  it "Should ignore phone numbers in the field" do
    PriceParser.new({:price=>"\r\n\t\tJUST ARRIVED631-369-0600\r\n\t\t\r\n\t",:year=>2008}).get_price.should==0
  end
  
  it "Should gracefully handle nil prices" do
    PriceParser.new({:price=>nil,:year=>2000}).get_price.should==0
  end
  
  it "Should gracefully handle nil year" do
    PriceParser.new({:price=>nil,:year=>nil}).get_price.should==0
  end
  
  it "Should handle lots of tabs and new lines" do
    PriceParser.new({:price=>"\r\n\t\t\t\r\n\t\t\t\t$112,175\r\n\t\t\t\r\n\t\t"}).get_price.should==112175
  end

  it "Should handler longer description" do
    PriceParser.new({:price=>"ASKING $32,000 IF YOUR INTERESTED EMAIL OR CALL KEVIN",:skip_keywords=>true}).get_price.should==32000
  end

  it "Should remove years that are 2 digits" do
    PriceParser.new({:price=>"04 Escalade $15,000",:skip_keywords=>true,:year=>2004}).get_price.should==15000
  end
end
