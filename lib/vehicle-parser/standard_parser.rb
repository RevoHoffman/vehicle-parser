class StandardParser
  def initialize(hash_params)
    @description=hash_params[:description]
    @regex=hash_params[:regex]
    @hash=hash_params[:hash]
  end

  def get_value
    return nil if @description.nil?
    match=@description[@regex]
    @hash[("_"+match.gsub("-","_").gsub(" ","_").strip.downcase).to_sym]  if !match.nil?
  end
  
  def cleanse_description
    return @description if @description.blank?
    temp=@description.gsub(@regex,"")
    temp.strip.gsub("  "," ").strip
  end
end