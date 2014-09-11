class DriveTrainParser
  
  def initialize(description)
    @description=description
    @parser=StandardParser.new({:description=>@description,:regex=>get_drive_train_regex,:hash=>get_drive_train_hash})
  end

  def get_drive_train
    @parser.get_value
  end
  
  def get_drive_train_from_large_block_of_text
    dt=@description[get_drive_train_regex]
    if !dt.nil?
      dt=dt.gsub(/(wheel drive|drive train|drivetrain)/i,"").strip if !dt.nil?
      @parser=StandardParser.new({:description=>dt,:regex=>Regexp.new('\bawd|\brwd|\bfwd|\b4wd|\b4x4|\ball wheel drive|\ball-wheel drive|\ball|\bfront wheel drive|\bfront-wheel drive|\bfront|\brear wheel drive|\brear-wheel drive|\brear|\bfour|\b4-wheel drive|\b4-wheel|\b4-|\bfour wheel drive',Regexp::IGNORECASE),:hash=>get_drive_train_hash})
      get_drive_train
    end
  end
  
  
  def cleanse_description
    description=@parser.cleanse_description
    description.gsub!(/2wd/i,"") if !description.nil?
    description.strip
  end
  
  def get_drive_train_regex
    Regexp.new('(\bawd\b|\brwd\b|\bfwd\b|\b4wd\b|4x4)|((\brear\b|\bfour\b|\b4\b|\bfront\b|\ball\b) ?-?(wheel drive|drive train|drivetrain))',Regexp::IGNORECASE)
  end
  
  def get_drive_train_hash
    {:_awd=>"AWD",:_rwd=>"RWD",:_fwd=>"FWD",:_4wd=>"4x4",:_4x4=>"4x4",:_all_wheel_drive=>"AWD",:_all=>"AWD",:_front=>"FWD",:_front_wheel_drive=>"FWD",:_rear_wheel_drive=>"RWD",:_rear=>"RWD",:_four=>"4x4",:_4_wheel=>"4x4",:_4_wheel_drive=>"4x4",:_4_=>"4x4",:_four_wheel=>"4x4",:_four_wheel_drive=>"4x4"}
  end
end