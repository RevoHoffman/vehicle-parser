class TransmissionParser
  def initialize(description)
    @description=description
    @parser=StandardParser.new({:description=>description,:regex=>get_transmission_regex,:hash=>get_transmission_hash})
  end

  def get_transmission(require_transmission_keyword=false)
    return nil if @description.nil?
    return nil if @description[/trans/i].nil? && require_transmission_keyword
    @parser.get_value
  end
  
  def cleanse_description
    description=@parser.cleanse_description
    description.gsub(Regexp.new('\d ?-?(speed|spd)',Regexp::IGNORECASE),"").strip
  end
  
  def get_transmission_regex
    Regexp.new('\bautomatic\b|\bauto\b|\bmanual\b|\bman\b|\bmt\b|\bcvt\b|\bat\b|\btiptronic\b|\bsteptronic\b|\b4matic\b|\ba\b|\bm\b',Regexp::IGNORECASE)
  end
  
  def get_transmission_hash
    {:_automatic=>"Automatic",:_auto=>"Automatic",:_at=>"Automatic",:_man=>"Manual",:_manual=>"Manual",:_mt=>"Manual",:_cvt=>"Automatic",:_tiptronic=>"Automatic",:_steptronic=>"Automatic",:_4matic=>"Automatic",:_a=>"Automatic",:_m=>"Manual"}
  end
end