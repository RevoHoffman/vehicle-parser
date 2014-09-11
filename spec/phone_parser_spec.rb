require 'spec_helper'

describe PhoneParser do
  it "should return nil if phone is nil" do
    PhoneParser.parse_phone(nil).should==nil
  end

  it "should parse phone number" do
    PhoneParser.parse_phone("Fax 850-796-6707").should=="850-796-6707"
  end
  
  it "should parse phone number in the middle of the string" do
    PhoneParser.parse_phone("Fax 850-796-6707 and other stuff").should=="850-796-6707"
  end
  
  it "should parse phone number with or without dashes" do
     PhoneParser.parse_phone("Fax 850 796 6707 and other stuff").should=="850-796-6707"
  end
  
  it "should parse phone number and convert spaces into dashes" do
     PhoneParser.parse_phone("Fax 850 796 6707 and other stuff").should=="850-796-6707"
  end
  
  it "should handle parenthesis in the phone number" do
     PhoneParser.parse_phone("Phone: (800) 643-2999").should=="800-643-2999"
  end
  
  it "should gracefully handle non valid phone numbers" do
     PhoneParser.parse_phone("Fax: 0").should==nil
  end
  
  it "should remove leading 1- from the phone number" do
     PhoneParser.parse_phone("1-888-744-9315").should=="888-744-9315"
  end
  
  it "should handle phrases like Toll Free" do
     PhoneParser.parse_phone("Fax: (Toll Free) 1-888-744-9315").should=="888-744-9315"
  end
  
  it "should handle dots as delimters in the phone number" do
     PhoneParser.parse_phone("Phone: 205.226.0929").should=="205-226-0929"
  end
  
  it "should handle extra spaces in the phone number" do
     PhoneParser.parse_phone("Sales: (888) 249 - 5117").should=="888-249-5117"
  end
  
  it "should keep the formatting proper" do
     PhoneParser.parse_phone("Sales: (856)330-1500").should=="856-330-1500"
  end

  it "should parse numbers written as text" do
    PhoneParser.parse_phone("979-four zero two-9981").should=="979-402-9981"
  end

  it "should parse numbers written as text" do
    PhoneParser.parse_phone("979-four oh two-9981").should=="979-402-9981"
  end

  it "should parse numbers written as text" do
    PhoneParser.parse_phone("979-four o two-9981").should=="979-402-9981"
  end

  it "should parse numbers written as text" do
    PhoneParser.parse_phone("1- 800 -3 five 4 - 4 one 3 one").should=="800-354-4131"
  end
end
