class FuelTypeParser
  def initialize(description)
    @description=description
  end

  def get_fuel_type
    return nil if @description.nil?
    return "Electric" if !@description[/\belectric\b/i].nil? if @description[/\bfuel\b/i].nil?
    return "Natural Gas" if !@description[/natural gas/i].nil?
    return "Gasoline" if !@description[/gas/i].nil?
    return "Diesel" if !@description[/dies/i].nil?
    return "Hybrid" if  !@description[/\bhybrid\b/i].nil?
    return "Gasoline" if  !@description[/\bfuel\b/i].nil?
    return "Gasoline" if !@description[/\bunleaded\b/i].nil?
  end
end