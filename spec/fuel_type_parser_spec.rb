require 'spec_helper'

describe "Fuel Type Parser","get_fuel_type" do
  it "should return nil if passed in nil" do
    parser=FuelTypeParser.new(nil)
    parser.get_fuel_type.should==nil
  end

  it "should return gas if description contains gas" do
    parser=FuelTypeParser.new("gasoline")
    parser.get_fuel_type.should=="Gasoline"
  end
  
  it "should return diesel if description contains dies" do
    parser=FuelTypeParser.new("dies")
    parser.get_fuel_type.should=="Diesel"
  end
  
  it "should return nil if no match is made" do
    parser=FuelTypeParser.new("kittens")
    parser.get_fuel_type.should==nil
  end

  it "should match for natural gas engines" do
    parser=FuelTypeParser.new("natural gas")
    parser.get_fuel_type.should=="Natural Gas"
  end

  it "should match for electric" do
    parser=FuelTypeParser.new("electric engine")
    parser.get_fuel_type.should=="Electric"
  end

  it "should not match for electrical or other similar words" do
    parser=FuelTypeParser.new("electrical fire was here")
    parser.get_fuel_type.should==nil
  end

  it "should not match electric for electric fuel system" do
    parser=FuelTypeParser.new("electric fuel system")
    parser.get_fuel_type.should=="Gasoline"
  end

  it "should match for hybrid" do
    parser=FuelTypeParser.new("awesome hybrid engine of suck")
    parser.get_fuel_type.should=="Hybrid"
  end
end
