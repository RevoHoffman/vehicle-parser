require 'spec_helper'

describe "Door Parser" do
  it "should return nil if passed in nil" do
    parser=DoorParser.new(nil)
    parser.get_doors.should==nil
  end

  it "should return the proper number of doors if doors is in the <door>dr format" do
    parser=DoorParser.new("4dr Sdn 3.2L quattro")
    parser.get_doors.should=="4"
  end

  it "should return nil of no doors were found" do
    parser=DoorParser.new("Sdn 3.2L quattro")
    parser.get_doors.should==nil
  end

  it "should cleanse the description <door>dr format" do
    parser=DoorParser.new("4dr Sdn 3.2L quattro")
    parser.cleanse_description.should=="Sdn 3.2L quattro"
  end

  it "should cleanse the description <door>dr format even if DR is app caps" do
    parser=DoorParser.new("4DR SDN 3.2L quattro")
    parser.cleanse_description.should=="SDN 3.2L quattro"
  end
  
  it "should cleanse the description <door>dr format, even if the doors aren't in the beginning of the description" do
    parser=DoorParser.new("Sdn 3.2L 4dr quattro")
    parser.cleanse_description.should=="Sdn 3.2L quattro"
  end
  
  it "should cleanse a description properly even if the description is nil" do
    parser=DoorParser.new("")
    parser.cleanse_description.should==""
  end
  
  it "should cleanse a description properly even if the description has no doors" do
    parser=DoorParser.new("Basic")
    parser.cleanse_description.should=="Basic"
  end
  
  it "should determine the number of doors even if the doors is in all caps" do
    parser=DoorParser.new("4DR SDN")
    parser.get_doors.should=="4"
  end
  
  it "should determine the number of doors if the doors are in the format of 'doors'" do
    parser=DoorParser.new("4 door Sedan")
    parser.get_doors.should=="4"
  end
  
  it "should parse a body type that has a door included in it" do
    parser=DoorParser.new("4 Dr. Wagon")
    parser.get_doors.should=="4"
  end
  
  it "should cleanse a description that has an abbreviated door label in it" do
    parser=DoorParser.new("4 Dr. Wagon")
    parser.cleanse_description.should=="Wagon"
  end
  
  it "should parse the door in the format of 5-Door" do
    parser=DoorParser.new("5-Door EX-L")
    parser.get_doors.should=="5"
  end

  it "should cleanse a description in the format of 5-Door" do
    parser=DoorParser.new("5-Door EX-L")
    parser.cleanse_description.should=="EX-L"
  end
  
  it "should cleanse a description in the format of 2d" do
    parser=DoorParser.new("2d EX-L")
    parser.cleanse_description.should=="EX-L"
  end
  
  it "should cleanse a description in the format of 5-Door in the middle of the description" do
    parser=DoorParser.new("Some 5-Door EX-L")
    parser.cleanse_description.should=="Some EX-L"
  end
end
