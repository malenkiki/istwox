# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

describe Istwox::ISTC, "Test International Standard Text Code implementation" do

  it "" do
      pending "Must more tests for ISTC"
      istc = Istwox::ISTC.new ""
      istc.should be
  end

  it "03A-2009-000C299F-D should have check digit 'D'" do
      istc = Istwox::ISTC.new "03A-2009-000C299F-D"
      istc.check_digit.should == 'D'
  end
  
  it "0A3-2009-012445C9-B should have check digit 'B'" do
      istc = Istwox::ISTC.new "0A3-2009-012445C9-B"
      istc.check_digit.should == 'B'
  end
  
  it "03A2009000C299F should have check digit 'D'" do
      istc = Istwox::ISTC.new "03A2009000C299F"
      istc.check_digit.should == 'D'
  end
  
  it "0A32009012445C9 should have check digit 'B'" do
      istc = Istwox::ISTC.new "0A32009012445C9"
      istc.check_digit.should == 'B'
  end
  
  it "03A2009000C299F should have registration element '03A'" do
      istc = Istwox::ISTC.new "03A2009000C299F"
      istc.registration.should == '03A'
  end
  
  it "0A32009012445C9 should have registration element '0A3'" do
      istc = Istwox::ISTC.new "0A32009012445C9"
      istc.registration.should == '0A3'
  end
  
  it "03A2009000C299F should have year element '2009'" do
      istc = Istwox::ISTC.new "03A2009000C299F"
      istc.year.should == '2009'
  end
  
  it "0A32009012445C9 should have year element '2009'" do
      istc = Istwox::ISTC.new "0A32009012445C9"
      istc.year.should == '2009'
  end

  it "0A32009012445C9 should have textual work element '012445C9'" do
      istc = Istwox::ISTC.new "0A32009012445C9"
      istc.textual_work.should == '012445C9'
  end
  
  it "03A2009000C299F should have textual work element '000C299F'" do
      istc = Istwox::ISTC.new "03A2009000C299F"
      istc.textual_work.should == '000C299F'
  end
  
  it "03A-2009-000C299F-D should be formated to 'ISTC 03A-2009-000C299F-D'" do
      istc = Istwox::ISTC.new "03A-2009-000C299F-D"
      istc.to_s.should == 'ISTC 03A-2009-000C299F-D'
  end
  
  it "0A3-2009-012445C9-B should be formated to 'ISTC 0A3-2009-012445C9-B'" do
      istc = Istwox::ISTC.new "0A3-2009-012445C9-B"
      istc.to_s.should == 'ISTC 0A3-2009-012445C9-B'
  end
  
  it "03A2009000C299F should be formated to 'ISTC 03A-2009-000C299F-D'" do
      istc = Istwox::ISTC.new "03A2009000C299F"
      istc.to_s.should == 'ISTC 03A-2009-000C299F-D'
  end
  
  it "0A32009012445C9 should be formated to 'ISTC 0A3-2009-012445C9-B'" do
      istc = Istwox::ISTC.new "0A32009012445C9"
      istc.to_s.should == 'ISTC 0A3-2009-012445C9-B'
  end
  
end

