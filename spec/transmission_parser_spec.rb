require 'spec_helper'

describe "Transmission Parser","get_transmission" do
  it "should return nil if passed in nil" do
    parser=TransmissionParser.new(nil)
    parser.get_transmission.should==nil
  end

  it "should return automatic if description contains automatic" do
    parser=TransmissionParser.new("automatic")
    parser.get_transmission.should=="Automatic"
  end

  it "should return automatic if description contains auto" do
    parser=TransmissionParser.new("this car has auto trans")
    parser.get_transmission.should=="Automatic"
  end

  it "should return manual if description contains manual" do
    parser=TransmissionParser.new("manual transmission")
    parser.get_transmission.should=="Manual"
  end

  it "should return manual if description contains man" do
    parser=TransmissionParser.new("cool man transmission")
    parser.get_transmission.should=="Manual"
  end
  
  it "should return manual if description contains mt" do
    parser=TransmissionParser.new("cool mt transmission")
    parser.get_transmission.should=="Manual"
  end

  it "should not find the transmission mid-word" do
    parser=TransmissionParser.new("I have some karMAN speakers")
    parser.get_transmission.should==nil
  end
  
  it "should return nil if the word transmission isn't in the sentence and the require_transmission_keyword param is true" do
    parser=TransmissionParser.new("Automatic hairdryer included")
    parser.get_transmission(true).should==nil
  end
  
  it "should return the transmission if the word transmission isn't in the sentence and the require_transmission_keyword param is false" do
    parser=TransmissionParser.new("Automatic hairdryer included")
    parser.get_transmission.should=="Automatic"
  end
  
  it "should return Automatic if the transmission is CVT" do
     parser=TransmissionParser.new("CVT transmission")
     parser.get_transmission.should=="Automatic"
  end
  
  it "should find AT as an automatic transmission" do
     parser=TransmissionParser.new("3.0L AT PreRunner")
     parser.get_transmission.should=="Automatic"
  end
  
  it "should find Tiptronic as an automatic transmission" do
      parser=TransmissionParser.new("3.0L Tiptronic PreRunner")
      parser.get_transmission.should=="Automatic"
    end
    
  it "should find Steptronic as an automatic transmission" do
    parser=TransmissionParser.new("3.0L Steptronic PreRunner")
    parser.get_transmission.should=="Automatic"
  end
  
  it "should find 4MATIC as an automatic transmission" do
    parser=TransmissionParser.new("3.0L 4MATIC PreRunner")
    parser.get_transmission.should=="Automatic"
  end
  
  it "should find A as an automatic transmission" do
    parser=TransmissionParser.new("A")
    parser.get_transmission.should=="Automatic"
  end
  
  it "should not find automatic transmission just because a word starts or includes A" do
    parser=TransmissionParser.new("Astronomical")
    parser.get_transmission.should==nil
  end

  it "should find M as a manual transmission" do
    parser=TransmissionParser.new("m")
    parser.get_transmission.should=="Manual"
  end
  
  it "should not find manual transmission just because a word starts or includes M" do
    parser=TransmissionParser.new("Maps")
    parser.get_transmission.should==nil
  end
  
  it "Should identify 4MATIC as an automatic transmission" do
    parser=TransmissionParser.new("4MATIC")
    parser.get_transmission.should=="Automatic"
  end
  
  it "should cleanse the transmission" do
    parser=TransmissionParser.new("CVT EX w/Navi")
    parser.cleanse_description.should=="EX w/Navi"
  end
  
  it "should cleanse the transmission even if it is not in the beginning of the description" do
    parser=TransmissionParser.new(" EX w/Navi CVT whatever")
    parser.cleanse_description.should=="EX w/Navi whatever"
  end
  
  it "should cleanse the transmission when it has a manual transmission" do
     parser=TransmissionParser.new("4dr Sdn I4 Manual 2.5")
     parser.cleanse_description.should=="4dr Sdn I4 2.5"
   end
   
   it "should cleanse the transmission when the transmission is the middle of the description" do
      parser=TransmissionParser.new("2008 Chevrolet Corvette automatic 2 door rear-wheel drive coupe Z06")
      parser.cleanse_description.should=="2008 Chevrolet Corvette 2 door rear-wheel drive coupe Z06"
   end
   
   it "should cleanse the transmission when the transmission is 'mt'" do
      parser=TransmissionParser.new("Trim mt")
      parser.cleanse_description.should=="Trim"
   end
    
   it "Should only cleanse terms that match whole word boundaries" do
     parser=TransmissionParser.new("Trim Atwood")
     parser.cleanse_description.should=="Trim Atwood"
   end
   
   it "Should remove the transmission speed" do
     parser=TransmissionParser.new("5 speed foo")
     parser.cleanse_description.should=="foo"
   end
end
