require 'spec_helper'

describe "Mileage Parser","get_mileage_tokens?" do
  it "should return mileage if the mileage precedes the mileage token" do
    MileageParser.get_mileage_tokens("this vehicle has 4000 miles on it").should include(4000)
  end

  it "should return mileage if the mileage precedes the mileage token" do
    MileageParser.get_mileage_tokens("this vehicle has miles 4000 on it").should include(4000)
  end

  it "should return mileage even if the token is the last word in the text" do
    MileageParser.get_mileage_tokens("this vehicle 4000 miles").should include(4000)
  end

  it "should return mileage even if the token is the first word in the text" do
    MileageParser.get_mileage_tokens("miles 4000").should include(4000)
  end

  it "should return mileage when the label has a colon after it" do
    MileageParser.get_mileage_tokens("miles: 4000").should include(4000)
  end

  it "should return mileage when the label is mileage" do
    MileageParser.get_mileage_tokens("mileage 4000").should include(4000)
  end

  it "should return mileage when the label is mileage and is contained in the string" do
    MileageParser.get_mileage_tokens("this car rocks miles 4000 on it").should include(4000)
  end
end

describe "Mileage Parser","get_vehicle_mileage" do
  it "should return nil if passed in nil" do
    MileageParser.get_vehicle_mileage(nil).should==nil
  end

  it "should convert mileage if measured in thousands of miles" do
    MileageParser.get_vehicle_mileage("This car has 169k miles on it").should==169000
  end

  it "should convert mileage if mileage has commas in it" do
    MileageParser.get_vehicle_mileage("This car has rocks! MILeage: 213,121 miles. But it now!").should==213121
  end

  it "should determine mileage if it has a MI. abbreviation after it" do
    MileageParser.get_vehicle_mileage("This car has rocks! It has 34k mi. on it").should==34000
  end

  it "should convert XXX into 0's" do
    MileageParser.get_vehicle_mileage("good condicion only 67xxx miles call me now").should==67000
  end

  it "should return nil if there is no mileage tokens in the text" do
    MileageParser.get_vehicle_mileage("1981 Corvette * Damaged" ).should==nil
  end

  it "should parse the mileage when the word miles is used but not without a specifc number" do
    MileageParser.get_vehicle_mileage("This low miles car is great. Low miles I said! It has 43k miles and is good to go!").should==43000
  end

  it "should parse the mileage when there are line breaks in the description" do
    MileageParser.get_vehicle_mileage("AUTOMATIC\n4 CYLINDER\n79K MILES\nRUNS AND DRIVE LIKE NEW").should==79000
  end

  it "should parse the mileage when there are line breaks in the description" do
    MileageParser.get_vehicle_mileage("162k miles. 2147558178").should==162000
  end

  it "should parse the mileage when the mileage is surrounded by parenthesis" do
    MileageParser.get_vehicle_mileage("(162k miles)").should==162000
  end

  it "should parse the mileage when the mileage has adjectives like highway" do
    MileageParser.get_vehicle_mileage("This vehicle has 123000 highway miles").should==123000
  end

  it "should remove ~ from mileage" do
    MileageParser.get_vehicle_mileage("This vehicle has ~123000 highway miles").should==123000
  end

  it "should remove 'original' from mileage" do
    MileageParser.get_vehicle_mileage("This vehicle has ~123000 original highway miles").should==123000
  end

  it "should parse hwy miles" do
    MileageParser.get_vehicle_mileage("It has 110000 hwy miles this tru").should==110000
  end

  it "should parse dumb descriptions" do
    MileageParser.get_vehicle_mileage("...4.6L engine running good. ......121k.....cold ").should==121000
  end

  it "should choose smart choice for mileage" do
    MileageParser.get_vehicle_mileage(" 2007 Dodge Durango Limited 4x4 - Color Black. Great Condition - Clean. Loaded - Leather seats, custom wheels, remote start, factory Alpine stereo with 6 cd changer with subwoofer, power sunroof, rear entertainment system, navigation system, rear air, heated seats (front and middle row) third row seating (folds down for more storage), factory neutral tow switch for rv car towing. 74,000 miles at time of posting. Asking $15,900 NADA $16,725
").should==74000
  end

  it "should choose smart choice for mileage II" do
    MileageParser.get_vehicle_mileage("2007 1ton 4x4 dodge, new motor with paperwork, has James norstram DTT transmission , cold ac, it's a Laramie with leather seats and seat heaters, power sliding back glass, b&w hideaway gooseneck hitch, 2.5 leveling kit, 2 wheel spacers, touch screen navigation, DVD player, 35 tires, truck has 250k miles, but motor and transmission only have about 30k miles on it, the truck looks like it does with the ranch hand on it in the pictures, but I still have the stalk bumper and other stalk stuff that goes with it, runs great, i owe 15k on it so that is my bottom dollar, texting is best 9407365321").should==250000
  end

  it "Should convert mileage when it has exclamation marks" do
    MileageParser.get_vehicle_mileage("With only 93k!").should==93000
  end

  it "Should convert mileage when it has periods" do
    MileageParser.get_vehicle_mileage("With only 93k.").should==93000
  end

  it "Should convert mileage when it has k and a +" do
    MileageParser.get_vehicle_mileage("With only 93k+ miles").should==93000
  end

  it "Should prioritze words that end in 'k'" do
    MileageParser.get_vehicle_mileage("Air filter cleaned every 8000 miles with only 138k on it").should==138000
  end

   it "Should handle mileage with an apostrophe" do
    MileageParser.get_vehicle_mileage("Car has 119`000 miles").should==119000
  end

   it "Handle STUPID MILEAGE PHRASES ROUND 937" do
    MileageParser.get_vehicle_mileage("I'm a CL poster and I am an idiot that can't write. Odometer: 17,360 I speak in a strange language").should==17360
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 1015" do
    MileageParser.get_vehicle_mileage("I'm a CL poster and I am an idiot that can't write. odo: 17,360").should==17360
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 1034" do
    MileageParser.get_vehicle_mileage("I'm a CL poster and I am an idiot that can't write. odo has 17360").should==17360
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 1218" do
    MileageParser.get_vehicle_mileage("Hi. I post to CL and I am a complete moron. 2006 F350 6.0 DIESEL ,355 K, NEW TURBO").should==355000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 1623" do
    MileageParser.get_vehicle_mileage("Hi. I post to CL and I am a complete moron. Mileage is 168500").should==168500
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 1921" do
    MileageParser.get_vehicle_mileage("Hi. I post to CL and I am a complete moron. -149xxx Daily driver so miles will go up").should==149000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 2028" do
    MileageParser.get_vehicle_mileage("Hi. I post to CL and I am a complete moron. 281 HP 4.2 liter inline 6 cylinder, 4x4, 95,000 mostly highway miles").should==95000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 2254" do
    MileageParser.get_vehicle_mileage("3.5 V6 High Output. 97XXX. Clean inside and out. Cloth seats. New tires. New struts. Power everything including adjustable pedals. Flowmaster exhaust. ").should==97000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 2921" do
    MileageParser.get_vehicle_mileage("\n\t\t2010 Dodge Charger SXT 469-324-7982 \n*BLACK  \n*86,000 MILES \n*NAVI \n*22'RIMS \n*CUSTOM HEAD LIGHTS & REAR LIGHTS \n*POWER SEATS  \n*BACK UP CAMERA  \n\t").should==86000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 3028" do
    MileageParser.get_vehicle_mileage("4.6L V8 Auto Trans 96,000 hi way miles (Daily driver to work and back)").should==96000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND 3287" do
    MileageParser.get_vehicle_mileage("Has only 65,149miles. Call or text me at (469) 556-6506").should==65149
  end

  it "Handle STUPID MILEAGE PHRASES ROUND omg..." do
    MileageParser.get_vehicle_mileage("100.000 miles. Beige...gold..?Runs over good!").should==100000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND MAKE IT STOP!..." do
    MileageParser.get_vehicle_mileage("V6 3.7 liter engine,102,987 miles, bed liner, brand new shocks, newish tires & upgraded Kenwood 2/10's sound system. Truck runs great! no mechanical ").should==102987
  end
  
  it "Handle STUPID MILEAGE PHRASES ROUND..Where's my vodka?" do
    MileageParser.get_vehicle_mileage("i have here a 07 Dodge Caliber with 185.XXX with good motor n transmission ").should==185000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND..I want to be a truck driver" do
    MileageParser.get_vehicle_mileage("For sale ford 250 turbo diesel power stroke, engine 6.0 Good tire,good AC, clean inside,191820 milles.call 9727750917").should==191820
  end

  it "Handle STUPID MILEAGE PHRASES ROUND..I'm an empty soul now." do
    MileageParser.get_vehicle_mileage("Interior exelent condition 101,000 miles Works inmediatle for to go").should==101000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND..I'm an empty soul now." do
    MileageParser.get_vehicle_mileage("2007 ford focus se in excellent condition,190,000 miles well maintained,").should==190000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND omg..." do
    MileageParser.get_vehicle_mileage( "I have 2006 Ford Taurus Ex 113 xxx miles four door ").should==113000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND omg..." do
    MileageParser.get_vehicle_mileage( "2008 Ford Scape \n6 Cylinder, \nSalvage Title\nMotor 3.0L Gas Saver\nAutomatic Transmision\nColor Blue Metalic\nRun and Good Condition\n139, 000 Miles").should==139000
  end

  it "Handle STUPID MILEAGE PHRASES ROUND omg..." do
    MileageParser.get_vehicle_mileage( "Wow only has 44, 500 miles, driven less than 10, 000 miles per year,\nIts a great suv, for daily diving, camping, boating or towing.\nIt very roomy and has dual ac. Tires in great shape. Clean carfax amd autocheck.").should==44500
  end

  it "Handle STUPID MILEAGE PHRASES ROUND omg..." do
    MileageParser.get_vehicle_mileage("For sale  Dodge Ram 1500 Quad stock\nV6 3.7 liter engine,102,987 miles, bed liner, brand new shocks, newish tires & upgraded Kenwood 2/10's sound system. Truck runs great! no mechanical issues! Cold A/C, manual locks & windows. Truck has").should==102987
  end

  it "Handle STUPID MILEAGE PHRASES ROUND omg..." do
    MileageParser.get_vehicle_mileage("2006 CHEVROLET 2500 HD EXT CAB 2WD LONG BED POWER WINDOWS , LOCKS AUTOMATIC TRANSMISSION TOWING EQUIPPED LIKE NEW GOOD LOOKING\nONE OWNER CLEAN CARFAX TX TRUCK\n250k HIGHWAY MILES WAS SERVICED EVERY 5K MILES ABSOLUTELY NO ISSUES\nDRIVES EXCELLENT DOESN'T HAVE ANY ISSUES STRONG MOTOR\nNO LEAKS NO BLOW BY\nAUTOMATIC TRANSMISSION WORKS PERFECT\nV8 6.0 ENGINE WORKS GREAT, STRONG WORKING CONDITION, DOES NOT LEAK, DOES NOT SMOKE\nCLEAN INSIDE AND OUTSIDE NICE PAINT\nVERY BEAUTIFUL\nTRUCK RUNS GREAT, EVERYTHING WORKS. I HAVE A CLEAN TITLE WITH ME\nPLEASE FEEL FREE TO TEXT OR CALL (817)368-4517").should==250000
  end

  it "should allow non-strict request so that we can parse mileage even with labels" do
    MileageParser.get_vehicle_mileage("Yes I have it , I buyed from a lady two months ago , truck has 180,000 just needs high pressure iol pump , it cranks but not start",false).should==180000
  end
end

 
