class MileageParser
  def self.get_vehicle_mileage(vehicle_text,strict=true)
    return nil if vehicle_text.blank?
    vehicle_text=vehicle_text.dup
    mileage_tokens=MileageParser.get_mileage_tokens(vehicle_text,strict)
    mileage_tokens.first if !mileage_tokens.blank? && mileage_tokens.count==1
    mileage_tokens.sort_by(&:to_i).reverse.first
  end

  def self.get_mileage_tokens(vehicle_text,strict=true)
    return nil if vehicle_text.empty?

    # Remove the year
    vehicle_year=VehicleYearParser.get_vehicle_year(vehicle_text).to_s
    vehicle_year=nil if vehicle_year.to_i < 1950 
    vehicle_text.gsub!((Regexp.new "\\b"+vehicle_year.to_s+"\\b"),"") if !vehicle_year.nil?

    words=vehicle_text.split(/ |-|\n|\.|\(/)
    MileageParser.get_adjectives_to_remove.each{|adj|words-=words.grep(/#{adj}/i)}
 
    # Try to fix stupid mileage here..
    r1=words.join(" ")[/\d+\, (\d+|xxx)/i]
    vehicle_text.gsub!(r1,r1.gsub(", ","")) if !r1.nil?
    words=vehicle_text.split(/ |-|\n|\.|\(/)
 
    token_locations=words.grep(/mile|mileage|mi|odometer|\bodo\b/i).uniq.map{|word|(0..words.length-1).find_all{|w| words[w]==word}}.flatten
    token_values=token_locations.map{|t|[words[t-1],words[t+1]]}.flatten.compact
    token_values=token_values.map{|t|MileageParser.get_mileage_value(t)}.reject{|t|t==0}.compact
    
    # Do we have mileage written like "121k"
    t=vehicle_text[/\d+ ?k/i]
    token_values << MileageParser.get_mileage_value(t) if !t.nil?
    t=vehicle_text[/\d+ ?\.?xxx/i]
    token_values << MileageParser.get_mileage_value(t) if !t.nil?
    
    # If we see the mileage label in the text, try and grab the mileage out
    if !vehicle_text[/mile|mileage|mi|odometer|\bodo\b/i].nil? || !strict
      t=vehicle_text[/((\b\d{2,3})(,|.)\d{3})|\b\d{4,5}\b/i]
      token_values << MileageParser.get_mileage_value(t) if !t.nil?
    end

    # We might have picked up some phone numbers. Delete numbers larger than 1MM if there are smaller numbers.
    token_values.reject!{|t|t > 1000000} if token_values.count > 0
    token_values
  end

  def self.get_mileage_value(mileage)
    mileage=mileage.gsub(/,|\~/,"")
    mileage=mileage.gsub(/\!|\.|`|'|\*/,"")
    mileage=mileage.gsub(/x/i,"0")
    mileage=mileage.gsub(/\?/,"0")
    if !mileage[/k|\+$/i].nil?
      mileage=mileage.to_i * 1000
    else
      mileage=mileage.gsub(" ","")[/\d+/]
    end
    mileage.to_i
  end

  def self.get_adjectives_to_remove
    ["highway","hwy","hiway","hi","way","actual","easy","original","has","the","mostly","mainly","primarily","rough","4x4"]
  end
end