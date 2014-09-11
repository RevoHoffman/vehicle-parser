require 'spec_helper'

describe "Is Engine Specs" do
  it "should return false if the word engine is not in the description" do
    parser=EngineParser.new("V6")
    parser.is_engine?(true).should==false
  end
  
  it "should only return true if the word engine is in the description" do
    parser=EngineParser.new("V6 engine")
    parser.is_engine?.should==true
  end
  
  it "should return false if no cylinders could be determined from the description" do
    parser=EngineParser.new("some awesomely cool engine")
    parser.is_engine?.should==false
  end
end

describe "Engine Parser","get_cylinders" do
  it "should return nil if passed in nil" do
    parser=EngineParser.new(nil)
    parser.get_cylinders.should==nil
  end
  
  it "should return 4 cylinders when engine contains I4" do
    parser=EngineParser.new("This snazzy I4 rocks")
    parser.get_cylinders.should=="4"
  end
  
  it "should return 6 cylinders when engine contains 6 Cylinders" do
    parser=EngineParser.new("Buy this 6 cylinder truck")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains 6 Cylinders" do
    parser=EngineParser.new("Buy this 6 cyl truck")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains 6 Cylinders" do
    parser=EngineParser.new("Buy this 6 cyl. truck")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains 6 Cylinders" do
     parser=EngineParser.new("Buy this 6 cylinders truck")
     parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains 6 Cylinders" do
     parser=EngineParser.new("Buy this 6 cylinders truck 8 days from now")
     parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains I6" do
    parser=EngineParser.new("This I6 is funny looking")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains V6" do
    parser=EngineParser.new("Blow 'em away in your V6")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains V-6" do
    parser=EngineParser.new("Rusty old V-6")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains v-6" do
    parser=EngineParser.new("Rusty old v-6")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains v 6" do
    parser=EngineParser.new("Rusty old v 6")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains v 12" do
    parser=EngineParser.new("Rusty old v 12")
    parser.get_cylinders.should=="12"
  end
  
  it "should return 6 cylinders when engine contains V-6 even when engine contains other numbers" do
    parser=EngineParser.new("Rusty old V-6. Call 8-10-6")
    parser.get_cylinders.should=="6"
  end
  
  it "should return 6 cylinders when engine contains V-6 even when engine contains other numbers before the engine" do
    parser=EngineParser.new("Call 8-10-6 to buy Rusty old V-6. Call 8-10-6")
    parser.get_cylinders.should=="6"
  end
  
  it "should return nil if no engine or cylinders is found in description" do
    parser=EngineParser.new("whatcha looking at?")
    parser.get_cylinders.should==nil
  end
  
  it "should return cylinders, not valves" do
    parser=EngineParser.new("3.8L OHV 12-valve SMPI V6 engine")
    parser.get_cylinders.should=="6"
  end
  
  it "should return numeric value of cylinders" do
    parser=EngineParser.new("2.4 4 Cyl.")
    parser.get_cylinders.should=="4"
  end
  
  it "should return numeric value of cylinders" do
     parser=EngineParser.new("2.4 4 Cyl")
     parser.get_cylinders.should=="4"
   end
  
  it "should return numeric value of cylinders" do
     parser=EngineParser.new("3.6 V6")
     parser.get_cylinders.should=="6"
   end
   
   it "should report valid engines as engines" do
     parser=EngineParser.new("3.6 V6")
     parser.is_engine?.should==true
   end
   
   it "should report valid engines as engines" do
     parser=EngineParser.new("3.5L")
     parser.is_engine?.should==true
   end
   
   it "should parse engines in the format of 3.5L" do
     parser=EngineParser.new("3.5L awesome car")
     parser.get_engine_description.should=="3.5L"
   end

  it "should parse engines in the format of v6)" do
     parser=EngineParser.new("(V6) awesome car")
     parser.get_engine_description.should=="V6"
   end
   
   it "should not try to determine the number of cylinders unless it knows we're dealing with a valid engine'" do
     parser=EngineParser.new("3.5L awesome car")
     parser.get_cylinders.should==nil
   end
   
   it "should determine the type of engine when there are two valid description'" do
     parser=EngineParser.new("4.7L V8 'MAGNUM engine")
     parser.get_cylinders.should=="8"
   end
   
    it "should determine the type of engine when its in the format of 4CYL'" do
      parser=EngineParser.new("4CYL")
      parser.get_cylinders.should=="4"
    end

    it "should determine the type of engine when its in the format of (v6)'" do
      parser=EngineParser.new("(v6)")
      parser.get_cylinders.should=="6"
    end
    
    it "should determine the type of engine when its in the format of 10 - CYL.'" do
      parser=EngineParser.new("(10 - CYL.)")
      parser.get_cylinders.should=="10"
    end
    
    it "should not use model names like V70 as an indicator of the engine" do
      parser=EngineParser.new("2001 Volvo V70 XC Wagon Gray AWD")
      parser.get_cylinders.should==nil
    end
end

describe "Engine Parser","cleanse_description" do
  it "should cleanse the engine description" do
    parser=EngineParser.new("EX V-6 w/Navi")
    parser.cleanse_description.should=="EX w/Navi"
  end  
  
  it "should cleanse the engine description with engines in the format of 3.5L" do
    parser=EngineParser.new("3.5L w/Navi")
    parser.cleanse_description.should=="w/Navi"
  end
  
  it "should cleanse the engine description with engines in the format of 3.5L" do
    parser=EngineParser.new("4.7L V8 'MAGNUM engine")
    parser.cleanse_description.should=="4.7L 'MAGNUM engine"
  end
end
