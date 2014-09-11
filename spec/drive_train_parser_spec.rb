require 'spec_helper'

describe "Drive Train Parser","get_drive_train" do
  it "should return nil if passed in nil" do
    parser=DriveTrainParser.new(nil)
    parser.get_drive_train.should==nil
  end

  it "should return nil if no known drive trains are present in description" do
    parser=DriveTrainParser.new("no drivetrains here.")
    parser.get_drive_train.should==nil
  end

  it "should return FWD if description contains FWD" do
    parser=DriveTrainParser.new("buy this fwd vehicle")
    parser.get_drive_train.should=="FWD"
  end

  it "should return rwd if description contains RWD" do
    parser=DriveTrainParser.new("buy this rwd vehicle")
    parser.get_drive_train.should=="RWD"
  end

  it "should return awd if description contains AWD" do
    parser=DriveTrainParser.new("buy this awd vehicle")
    parser.get_drive_train.should=="AWD"
  end

  it "should return 4wd if description contains 4wd" do
    parser=DriveTrainParser.new("buy this 4wd vehicle")
    parser.get_drive_train.should=="4x4"
  end

  it "should return 4wd if description contains 4x4" do
    parser=DriveTrainParser.new("buy this 4x4 vehicle")
    parser.get_drive_train.should=="4x4"
  end

  it "should not match a drivetrain found inside a word" do
    parser=DriveTrainParser.new("this gawd awful wreck")
    parser.get_drive_train.should==nil
  end
  
  it "should return nil if the description does not contain a drivetrain" do
    parser=DriveTrainParser.new("look at me with no drivetrains")
    parser.get_drive_train.should==nil
  end

  it "should identify 'all-wheel drive' as AWD" do
    parser=DriveTrainParser.new("all-wheel drive")
    parser.get_drive_train.should=="AWD"
  end
  
  it "should identify 'front wheel' as FWD" do
    parser=DriveTrainParser.new("front-wheel drive")
    parser.get_drive_train.should=="FWD"
  end
  
  it "should identify 'rear wheel' as FWD" do
    parser=DriveTrainParser.new("rear-wheel drive")
    parser.get_drive_train.should=="RWD"
  end

  it "should identify 'four wheel drive' as '4x4'" do
    parser=DriveTrainParser.new("Four Wheel Drive")
    parser.get_drive_train.should=="4x4"
  end
  
  it "should be able to pull a drivetrain from a large body of unrelated text" do
    parser=DriveTrainParser.new("This awesome car has all the options like ac and front wheel drive")
    parser.get_drive_train_from_large_block_of_text.should=="FWD"
  end
  
  it "should be able to pull a 4-wheel drivetrain from a large body of unrelated text" do
    parser=DriveTrainParser.new("<li>Permanent 4-wheel drive</li>")
    parser.get_drive_train_from_large_block_of_text.should=="4x4"
  end
  
  it "should not think that 4-wheel disk brakes makes a vehicle a 4x4" do
    parser=DriveTrainParser.new("4-wheel disk brakes")
    parser.get_drive_train_from_large_block_of_text.should==nil
    
    parser=DriveTrainParser.new("4 wheel disk brakes")
    parser.get_drive_train_from_large_block_of_text.should==nil
    
    parser=DriveTrainParser.new("four-wheel disk brakes")
    parser.get_drive_train_from_large_block_of_text.should==nil
    
    parser=DriveTrainParser.new("four wheel disk brakes")
    parser.get_drive_train_from_large_block_of_text.should==nil
  end
  
  # it "should be able to pull a 4-wheel drivetrain from a large body of unrelated text" do
  #   parser=DriveTrainParser.new(" • Four-wheel drive")
  #   parser.get_drive_train_from_large_block_of_text.should=="4x4"
  # end

  
  it "should identify '4-wheel drive' as a 4x4" do
    parser=DriveTrainParser.new("Extended Cab Standard Box 4-Wheel Drive SLE")
    parser.get_drive_train.should=="4x4"
  end
  
  
  it "should not identify 4-speed as a 4x4" do
    parser=DriveTrainParser.new("4-speed transmission")
    parser.get_drive_train.should==nil
  end
end

describe "Drive Train Parser","cleanse_description tests" do
  it "should cleanse a description properly" do
    parser=DriveTrainParser.new("4WD 4dr Tech Pkg")
    parser.cleanse_description.should=="4dr Tech Pkg"
  end
  
  it "should cleanse a description properly even if the description is nil" do
    parser=DriveTrainParser.new("")
    parser.cleanse_description.should==""
  end
  
  it "should cleanse a description properly even if the drivetrain isn't at the beginning of the description" do
    parser=DriveTrainParser.new("I love my AWD truck")
    parser.cleanse_description.should=="I love my truck"
  end
  
  it "should cleanse a description properly even if the description has no drivetrains" do
    parser=DriveTrainParser.new("Basic")
    parser.cleanse_description.should=="Basic"
  end
  
  it "should remove 2WD from the description, although it isn't a valid drivetrain." do
    parser=DriveTrainParser.new("2WD Access AT PreRunner")
    parser.cleanse_description.should=="Access AT PreRunner"
  end
  
  it "should cleanse descriptions that contains 4x4" do
    parser=DriveTrainParser.new("Extended Cab Standard Box 4-Wheel Drive SLE")
    parser.cleanse_description.should=="Extended Cab Standard Box SLE"
  end
  
  it "should cleanse descriptions that contains front wheel drive" do
    parser=DriveTrainParser.new("Extended Cab Standard Box front wheel drive SLE")
    parser.cleanse_description.should=="Extended Cab Standard Box SLE"
  end
  
  it "should cleanse descriptions that contains front-wheel drive" do
    parser=DriveTrainParser.new("Extended Cab Standard Box front-wheel drive SLE")
    parser.cleanse_description.should=="Extended Cab Standard Box SLE"
  end
  
  it "should cleanse descriptions that contains rear wheel drive" do
    parser=DriveTrainParser.new("Extended Cab Standard Box rear wheel drive SLE")
    parser.cleanse_description.should=="Extended Cab Standard Box SLE"
  end
  
  it "should cleanse descriptions that contains rear-wheel drive" do
    parser=DriveTrainParser.new("Extended Cab Standard Box rear-wheel drive SLE")
    parser.cleanse_description.should=="Extended Cab Standard Box SLE"
  end
  
  it "should cleanse descriptions that contains all wheel drive" do
    parser=DriveTrainParser.new("Extended Cab Standard Box all wheel drive SLE")
    parser.cleanse_description.should=="Extended Cab Standard Box SLE"
  end
  
  it "should cleanse descriptions that contains all-wheel drive" do
    parser=DriveTrainParser.new("Extended Cab Standard Box all-wheel drive SLE")
    parser.cleanse_description.should=="Extended Cab Standard Box SLE"
  end

end

