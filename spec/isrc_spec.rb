# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

describe Istwox::ISRC, "Test International Standard Recording Code implementation" do

  it "BR-BMG-03-00729 should be instanciated" do
      isrc = Istwox::ISRC.new "BR-BMG-03-00729"
      isrc.should be
  end
  
  it "BR-BMG-03-0072 should raise an error" do
      expect { Istwox::ISRC.new "BR-BMG-03-0072" }.to raise_error(ArgumentError)
      
  end
  
  it "BR-BMG-03-007291 should raise an error" do
      expect { Istwox::ISRC.new "BR-BMG-03-007291" }.to raise_error(ArgumentError)
      
  end
  
  it "BR-BMG-O3-00729 should raise an error" do
      expect { Istwox::ISRC.new "BR-BMG-O3-00729" }.to raise_error(ArgumentError)
      
  end
  
  it "8R-BMG-03-00729 should raise an error" do
      expect { Istwox::ISRC.new "8R-BMG-03-00729" }.to raise_error(ArgumentError)
      
  end
  
  
  it "BR-BMG-03-00729 should have country code BR" do
      isrc = Istwox::ISRC.new "BR-BMG-03-00729"
      isrc.country_code.should == 'BR'
  end
  
  it "BR-BMG-03-00729 should have registrant code BMG" do
      isrc = Istwox::ISRC.new "BR-BMG-03-00729"
      isrc.registrant_code.should == 'BMG'
  end
  
  it "BR-BMG-03-00729 should have year 03" do
      isrc = Istwox::ISRC.new "BR-BMG-03-00729"
      isrc.year.should == '03'
  end
  
  it "BR-BMG-03-00729 should have designation code 00729" do
      isrc = Istwox::ISRC.new "BR-BMG-03-00729"
      isrc.designation_code.should == '00729'
  end
  
  it "BRBMG0300729 should be formated to BR-BMG-03-00729" do
      isrc = Istwox::ISRC.new "BRBMG0300729"
      isrc.to_s.should == 'BR-BMG-03-00729'
  end
  
  it "US-PR3-73-00012 should be instanciated" do
      isrc = Istwox::ISRC.new "US-PR3-73-00012"
      isrc.should be
  end
  
  it "US-PR3-73-0001 should raise an error" do
      expect { Istwox::ISRC.new "US-PR3-73-0001" }.to raise_error(ArgumentError)
      
  end
  
  it "US-PR3-73-000123 should raise an error" do
      expect { Istwox::ISRC.new "US-PR3-73-000123" }.to raise_error(ArgumentError)
      
  end
  
  it "US-PR3-7E-00012 should raise an error" do
      expect { Istwox::ISRC.new "US-PR3-7E-00012" }.to raise_error(ArgumentError)
      
  end
  
  it "U5-PR3-73-00012 should raise an error" do
      expect { Istwox::ISRC.new "U5-PR3-73-00012" }.to raise_error(ArgumentError)
      
  end
  
  it "US-PR3-73-00012 should have country code " do
      isrc = Istwox::ISRC.new "US-PR3-73-00012"
      isrc.country_code.should == 'US'
  end
  
  it "US-PR3-73-00012 should have registrant code " do
      isrc = Istwox::ISRC.new "US-PR3-73-00012"
      isrc.registrant_code.should == 'PR3'
  end
  
  it "US-PR3-73-00012 should have year " do
      isrc = Istwox::ISRC.new "US-PR3-73-00012"
      isrc.year.should == '73'
  end
  
  it "US-PR3-73-00012 should have designation code " do
      isrc = Istwox::ISRC.new "US-PR3-73-00012"
      isrc.designation_code.should == '00012'
  end
  
  it "USPR37300012 should formated to US-PR3-73-00012" do
      isrc = Istwox::ISRC.new "USPR37300012"
      isrc.to_s.should == 'US-PR3-73-00012'
  end
end

