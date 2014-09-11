class EngineParser
  def initialize(description)
    @description=description
  end

  def get_cylinders
    return nil if @description.nil?
    engine=get_engine_description
    return nil if engine.nil?
    return nil if engine[/[VI-]| cyl|\dcyl/i].nil?
    engine=engine.to_i.to_s unless engine["cyl"].nil?
    
    engine.gsub!(/[VI-]/i,"")
    engine.gsub!(/ ?cyl/i,"")
    engine.gsub!(".","")
    engine.gsub!("(","")
    engine.gsub!(")","")
    engine.strip!

    return nil if engine == "0"
    engine
  end
  
  def get_engine_description
    engine=@description[/\b[VI][ -]?(12\b|11\b|10\b|9\b|8\b|7\b|6\b|5\b|4\b)/i]
    
    if engine.nil?
      engine=@description[/(\d{1,2})\s?-? ?cyl/i]
    end
    
    if engine.nil?
      engine=@description[/\d{1}.\d{1}L/i]
    end
    engine.strip if !engine.nil?
  end
  
  def cleanse_description
    return @description if @description.blank?
    description=String.new(@description)
    description.gsub(get_engine_description,"").gsub("  "," ").strip
  end
  
  def is_engine?(require_engine_keyword=false)
    return false if @description.nil?
    return false if @description[/engine/i].nil? && require_engine_keyword==true
    return false if get_engine_description.nil?
    true
  end
end
