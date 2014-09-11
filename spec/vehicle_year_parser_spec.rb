require 'spec_helper'


describe "Vehicle Year Parser","convert_two_digit_year_into_full_year?" do
  it "should return nil if passed in nil" do
    VehicleYearParser.convert_two_digit_year_into_full_year(nil).should==nil
  end

  it "should return nil if passed in a year that isn't two digits long" do
    VehicleYearParser.convert_two_digit_year_into_full_year("121").should==nil
  end
end

describe "Vehicle Year Parser","valid_year?" do
  it "should return nil if passed in nil" do
    VehicleYearParser.valid_year?(nil).should==false
  end
  
  it "should see 4 digits numbers from 1912 to current year as the year" do
    VehicleYearParser.valid_year?("2010").should==true
  end

  it "should return false if the year is below 1912" do
    VehicleYearParser.valid_year?("1900").should==false
  end

  it "should return false if the year is greater than today's year + 1" do
    VehicleYearParser.valid_year?(Time.new.year+2).should==false
  end

  it "should treat two digit numbers as a year in the current century if the two digit year is in the past or is current " do
    VehicleYearParser.valid_year?("07").should==true
  end
end


describe "Vehicle Year Parser","get_vehicle_year" do
  it "should return nil if passed in nil" do
    VehicleYearParser.get_vehicle_year(nil).should==nil
  end
  
  it "should see 4 digits numbers from 1912 to current year as the year" do
    VehicleYearParser.get_vehicle_year("This 2010 Honda").should=="2010"
  end

  it "should not use numbers greater than 5 digits" do
    VehicleYearParser.get_vehicle_year("This 20102 Honda").should==nil
  end

  it "should treat two digit numbers as a year in the current century if the two digit year is in the past or is current " do
    VehicleYearParser.get_vehicle_year("this is a 07 Honda").should==2007
  end

  it "should treat two digit numbers as a year in the last century" do
    VehicleYearParser.get_vehicle_year("this is a 86 Corvette").should==1986
  end

  it "should treat two digit numbers as a year when the year has a ' or ` in front of it" do
    VehicleYearParser.get_vehicle_year("this is a '86 Corvette").should==1986
    VehicleYearParser.get_vehicle_year("this is a `07 Corvette").should==2007
    VehicleYearParser.get_vehicle_year("07 Chevrolet Cobalt Lt for sale ").should==2007
    VehicleYearParser.get_vehicle_year("08 honda accord coupe lx-s").should==2008
  end

  it "should handle telephone numbers and not get confused" do
    VehicleYearParser.get_vehicle_year("INFO AT 972-271-0205").should==nil
  end
end
