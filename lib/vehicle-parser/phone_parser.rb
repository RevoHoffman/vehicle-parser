require 'active_support/core_ext'
require 'phone'

class PhoneParser
  def self.parse_phone(phone)
    return nil if phone.nil?
    p=phone.dup
    p.gsub!(/zero/i,"0")
    p.gsub!(/ o /i,"0")
    p.gsub!(/oh/i,"0")
    p.gsub!(/one/i,"1")
    p.gsub!(/two/i,"2")
    p.gsub!(/three/i,"3")
    p.gsub!(/four/i,"4")
    p.gsub!(/five/i,"5")
    p.gsub!(/six/i,"6")
    p.gsub!(/seven/i,"7")
    p.gsub!(/eight/i,"8")
    p.gsub!(/nine/i,"9")
    p.gsub!(/-| /,"")

    p=p[/\(?\d{3}\)?-? ?.?\d{3} ?-? ?.?\d{4}/]
    return nil if p.nil?
    p.slice!(0) if p[0]=="1"
    Phoner::Phone.default_country_code = '1'  
    pn=Phoner::Phone.parse(p)
    pn.format("%a-%f-%l")
  end
end