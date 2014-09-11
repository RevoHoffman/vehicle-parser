require 'spec_helper'

describe "Body Type Parser" do
  it "should return nil if passed in nil" do
    parser=BodyTypeParser.new(nil)
    parser.get_body_type.should==nil
  end

  it "should return the proper body type for Sdn" do
    parser=BodyTypeParser.new("4dr Sdn 3.2L quattro")
    parser.get_body_type.should=="Sedan"
  end
  
  it "should return the proper body type for Sedan" do
    parser=BodyTypeParser.new("4dr Sedan 3.2L quattro")
    parser.get_body_type.should=="Sedan"
  end
  
  it "should return the proper body type for Cpe" do
    parser=BodyTypeParser.new("4dr Cpe 3.2L quattro")
    parser.get_body_type.should=="Coupe"
  end
  
  it "should return the proper body type for Coupe" do
    parser=BodyTypeParser.new("4dr Coupe 3.2L quattro")
    parser.get_body_type.should=="Coupe"
  end
  
  it "should return the proper body type for Convertible" do
    parser=BodyTypeParser.new("4dr Convertible 3.2L quattro")
    parser.get_body_type.should=="Convertible"
  end
  
  it "should return the proper body type for Roadster" do
    parser=BodyTypeParser.new("2007 Aston Martin Vantage Roadster")
    parser.get_body_type.should=="Convertible"
  end
  
  it "should return the proper body type for Cabriolet" do
    parser=BodyTypeParser.new("1.8t quattro cabriolet")
    parser.get_body_type.should=="Convertible"
  end
  
  it "should return the proper body type for Convert" do
    parser=BodyTypeParser.new("4dr Convert 3.2L quattro")
    parser.get_body_type.should=="Convertible"
  end
  
  it "should return the proper body type for Conv" do
    parser=BodyTypeParser.new("6 Series 2dr Conv M6")
    parser.get_body_type.should=="Convertible"
  end
  
  it "should return the proper body type for SUV" do
    parser=BodyTypeParser.new("4dr SUV 3.2L quattro")
    parser.get_body_type.should=="SUV"
  end
  
  it "should return the proper body type for Hatchback" do
    parser=BodyTypeParser.new("4dr Hatchback 3.2L quattro")
    parser.get_body_type.should=="Hatchback"
  end
  
  it "should return the proper body type for Limousine" do
    parser=BodyTypeParser.new("4dr Limousine 3.2L quattro")
    parser.get_body_type.should=="Limousine"
  end
  
  it "should return the proper body type for Limousine" do
     parser=BodyTypeParser.new("4dr Limo 3.2L quattro")
     parser.get_body_type.should=="Limousine"
  end
  
  it "should return the proper body type for Minivan" do
    parser=BodyTypeParser.new("4dr Minivan 3.2L quattro")
    parser.get_body_type.should=="Minivan/Van"
  end
  
  it "should return the proper body type for Van" do
    parser=BodyTypeParser.new("4dr Van 3.2L quattro")
    parser.get_body_type.should=="Minivan/Van"
  end
  
  it "should return the proper body type for Wagon" do
    parser=BodyTypeParser.new("4dr Wagon 3.2L quattro")
    parser.get_body_type.should=="Wagon"
  end
  
  it "should return the proper body type for Wgn" do
    parser=BodyTypeParser.new("4dr Wgn 3.2L quattro")
    parser.get_body_type.should=="Wagon"
  end

  it "should return the proper body type for Truck" do
    parser=BodyTypeParser.new("4dr Truck 3.2L quattro")
    parser.get_body_type.should=="Pickup Truck"
  end
  
  it "should return the proper body type for Pickup" do
    parser=BodyTypeParser.new("4dr pickup 3.2L quattro")
    parser.get_body_type.should=="Pickup Truck"
  end
  
  it "should return the proper body type for Pickup Truck" do
    parser=BodyTypeParser.new("4dr pickup truck 3.2L quattro")
    parser.get_body_type.should=="Pickup Truck"
  end
  
  it "should return the proper body type for Work Truck" do
    parser=BodyTypeParser.new("4dr work truck 3.2L quattro")
    parser.get_body_type.should=="Pickup Truck"
  end
  
  it "should return the proper body type for Hatchback" do
    parser=BodyTypeParser.new("Trim hb")
    parser.get_body_type.should=="Hatchback"
  end
  
  it "should return the proper body type for Hatchback" do
    parser=BodyTypeParser.new("Trim liftback")
    parser.get_body_type.should=="Hatchback"
  end
  
  it "should return the proper body type for Hatchback" do
    parser=BodyTypeParser.new("Trim lb")
    parser.get_body_type.should=="Hatchback"
  end

  it "should return nil if no body type is found in the description" do
    parser=BodyTypeParser.new("3.2L quattro")
    parser.get_body_type.should==nil
  end

  it "should cleanse the description" do
    parser=BodyTypeParser.new("4dr Sdn 3.2L quattro")
    parser.cleanse_description.should=="4dr 3.2L quattro"
  end
  
  it "should cleanse a description properly even if the description is nil" do
    parser=BodyTypeParser.new("")
    parser.cleanse_description.should==""
  end
  
  it "should cleanse a description properly even if the description has no body type" do
    parser=BodyTypeParser.new("Basic")
    parser.cleanse_description.should=="Basic"
  end
  
  it "should cleanse a description for work truck" do
    parser=BodyTypeParser.new("4dr work truck 3.2L quattro")
    parser.cleanse_description.should=="4dr 3.2L quattro"
  end
  
  it "should parse a body type with doors into the proper body type" do
     parser=BodyTypeParser.new("4 Dr. Wagon")
     parser.get_body_type.should=="Wagon"
  end
   
  it "should cleanse a body type with doors into the proper body type" do
     parser=BodyTypeParser.new("4 Dr. Wagon")
     parser.cleanse_description.should=="4 Dr."
   end
   
   it "should cleanse a description when the body type is in the middle of the description" do
     parser=BodyTypeParser.new("4 Dr. Wagon supra")
     parser.cleanse_description.should=="4 Dr. supra"
   end
   
   it "should cleanse a description, but only on word boundardies" do
     parser=BodyTypeParser.new("4 Dr. Wagonsupra")
     parser.cleanse_description.should=="4 Dr. Wagonsupra"
   end
   
   it "should cleanse a description, even when the body type is repeated" do
     parser=BodyTypeParser.new("2010 Saab 9-3 Conv Convertible")
     parser.cleanse_description.should=="2010 Saab 9-3"
   end

    it "Should parse 2dr car into coupe" do
     parser=BodyTypeParser.new("2dr Car").get_body_type.should=="Coupe"
   end

    it "Should parse 4dr car into sedan" do
     parser=BodyTypeParser.new("4dr Car").get_body_type.should=="Sedan"
   end

    it "Should parse 5dr car into wagon" do
     parser=BodyTypeParser.new("5dr Car").get_body_type.should=="Wagon"
   end

    it "Should parse body types of Cab into pickup truck" do
     parser=BodyTypeParser.new("Regular Cab Chassis-Cab").get_body_type.should=="Pickup Truck"
   end
  
    it "Should parse body types of Sport Utility into pickup truck" do
     parser=BodyTypeParser.new("Sport Utility").get_body_type.should=="SUV"
    end

    it "Should parse body types of hatchback coupes into coupes" do
      parser=BodyTypeParser.new("Hatchback Coupe").get_body_type.should=="Coupe"
    end

    # it "Should handle the stupid that comes out of GM calling cars hatchbacks that are actually coupes" do
    #   parser=BodyTypeParser.new("Hatchback 2 Dr.").get_body_type.should=="Coupe"
    # end
end
