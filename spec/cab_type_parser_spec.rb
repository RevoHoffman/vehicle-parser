require 'spec_helper'

describe "Cab Type Parser" do
  it "should return nil if passed in nil" do
    parser=CabTypeParser.new(nil)
    parser.get_cab_type.should==nil
  end

  it "should return Crew Cab if it sees crew in the description" do
    parser=CabTypeParser.new("Crew Cab Pickup")
    parser.get_cab_type.should=="Crew Cab"
  end

  it "should return Extended Cab if it sees crew in the description" do
    parser=CabTypeParser.new("This is an Extended Cab Pickup")
    parser.get_cab_type.should=="Extended Cab"
  end

  it "should return Regular Cab if it sees reg in the description" do
    parser=CabTypeParser.new("This is an reg Cab Pickup")
    parser.get_cab_type.should=="Regular Cab"
  end

  it "should default to Regular Cab if nothing else matches but the work truck is in the description" do
    parser=CabTypeParser.new("This is a Pickup")
    parser.get_cab_type.should=="Regular Cab"
  end

  it "should default to Regular Cab if nothing else matches but the work pickup is in the description" do
    parser=CabTypeParser.new("This is an old truck")
    parser.get_cab_type.should=="Regular Cab"
  end
end
