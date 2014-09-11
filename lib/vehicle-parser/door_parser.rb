class DoorParser
  def initialize(description)
    @description=description
  end

  def get_doors()
    return nil if @description.nil?
    doors=get_door_matches
    if doors.nil? then nil else doors.gsub(/dr.?/i,"").gsub(/door/i,"").gsub("-","").strip end
  end
  
  def get_door_matches
    @description[/\d ?dr.? ?|\d ?-?door|\dd|\d-?dr/i]
  end
  
  def cleanse_description
    return @description if @description.blank?
    description=String.new(@description)
    doors=get_door_matches
    unless doors.nil?
      regex=doors
      doors.concat(' ?') unless description.starts_with?(doors) || description.ends_with?(doors)
      description.gsub!(Regexp.new(regex,Regexp::IGNORECASE),"") 
    end
    description.strip
  end
end