class BodyTypeParser
  def initialize(description)
    @description=description
    @parser=StandardParser.new({:description=>description,:regex=>get_body_type_regex,:hash=>get_body_type_hash})
  end

  def get_body_type
    if !@description.nil?
      words=@description.split
      if words.count > 1
        bodies=[]
        @description.split.each do |word|
          parser=StandardParser.new({:description=>word,:regex=>get_body_type_regex,:hash=>get_body_type_hash})
          bodies << parser.get_value
        end
        bodies << @parser.get_value
        bodies=bodies.compact.uniq
        # We do this because sometimes we see body types of "Hatchback Coupe" and we want to prioritize the coupe, not the hatchbakck.
        if bodies.count > 1
          return "Coupe" if bodies.include?("Coupe")
          return "Sedan" if bodies.include?("Sedan")
        end
      end
    end

    value=@parser.get_value
    num_doors=DoorParser.new(@description).get_doors
    if value.blank?
      value = case num_doors
        when "2" then "Coupe"
        when "4" then "Sedan"
        when "5" then "Wagon"
      end
    end
    value
  end
  
  def cleanse_description
    @parser.cleanse_description
  end
  
  def get_body_type_regex
    Regexp.new('\bcabriolet\b|\broadster\b|\bconvertible\b|\bconvert\b|\bconv\b|\bcoupe\b|\bcpe\b|\bhatchback\b|\bhb\b|\blb\b|\bliftback\b|\blimousine\b|\blimo\b|\bminivan\b|\bvan\b|\bsuv\b|\bwagon\b|\bwgn\b|\bwork truck\b|\bpickup truck\b|\bpickup\b|\btruck\b|\bsedan\b|\bsdn\b|\bcab\b|\bsport utility\b',Regexp::IGNORECASE)
  end
  
  def get_body_type_hash
    {:_cabriolet=>"Convertible",:_roadster=>"Convertible",:_convertible=>"Convertible",:_convert=>"Convertible",:_conv=>"Convertible",:_coupe=>"Coupe",:_cpe=>"Coupe",:_hatchback=>"Hatchback",:_hb=>"Hatchback",:_lb=>"Hatchback",:_liftback=>"Hatchback",:_limousine=>"Limousine",:_limo=>"Limousine",
      :_minivan=>"Minivan/Van",:_van=>"Minivan/Van",:_suv=>"SUV",:_wgn=>"Wagon",:_wagon=>"Wagon",:"_work_truck"=>"Pickup Truck",:"_pickup_truck"=>"Pickup Truck",:_pickup=>"Pickup Truck",:_truck=>"Pickup Truck",:_sedan=>"Sedan",:_sdn=>"Sedan",:_cab=>"Pickup Truck",:_sport_utility=>"SUV"}
  end
end