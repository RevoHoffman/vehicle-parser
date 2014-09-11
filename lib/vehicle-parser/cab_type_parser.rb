class CabTypeParser
  def initialize(description)
    @description=description
  end

  def get_cab_type
    return nil if @description.blank?
    return "Crew Cab" if !@description[/\bcrew/i].nil?
    return "Extended Cab" if !@description[/\bextended/i].nil?
    return "Regular Cab" if !@description[/\breg/i].nil?
    return "Regular Cab" if !@description[/\btruck\b|\bpickup\b/i].nil?
  end
end