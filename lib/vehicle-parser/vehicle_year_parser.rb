class VehicleYearParser
  def self.get_vehicle_year(vehicle_text)
    return nil if vehicle_text.blank?

    # Remove dollar signs and commas since that can cause issues
    vehicle_text = vehicle_text.gsub(/,|\$/,"")
    year=vehicle_text[/\b\d{4}\b|\b\d{2}\b/]
    year=VehicleYearParser.convert_two_digit_year_into_full_year(year.to_s.rjust(2,"0")) if !year.blank? && year.to_s.length < 4
    return year if VehicleYearParser.valid_year?(year)
  end

  def self.valid_year?(vehicle_year)
    return false if vehicle_year.blank?
    year=vehicle_year.to_i
    year=VehicleYearParser.convert_two_digit_year_into_full_year(year.to_s.rjust(2,"0"))  if !year.blank?  &&  year.to_s.length < 4
    return false if year.nil?
    return true if year > 1912 && year < Time.new.year+2
    false
  end

  def self.convert_two_digit_year_into_full_year(year)
    return nil if year.blank?
    return nil if year.to_s.length!=2
    current_year=Time.new.year
    current_century=(current_year.to_s[0..1]+"00").to_i
    full_year=current_century+year.to_i
    full_year > Time.new.year+1 ? current_century-100+year.to_i : full_year
  end
end