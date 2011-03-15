# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

# Some examples: Inception: 0000-0002-B3C8-0000-3-0000-0000-S
# Stargate Atlantis - Season 1 - Disc 2: 0000-0000-DDB0-0069-Q-0000-0000-X
# Stargate Atlantis - Season 1 - Disc 3: 0000-0000-DDB0-006A-O-0000-0000-2
# Stargate Atlantis - Season 1 - Disc 4: 0000-0000-DDB0-006B-M-0000-0000-8
describe Istwox::ISAN, "Test International Standard Audiovisual Number (ISAN)" do

  it "'' should not create ISAN" do
      pending "add test with constructor that must fail"
  end

  it "'0000-0002-B3C8-0000-3' should create valid ISAN" do
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3"
      ismn.should be
  end
  
  it "'00000002B3C800003' should create valid ISAN" do
      ismn = Istwox::ISAN.new "00000002B3C800003"
      ismn.should be
  end

  it "'00000002B3C80000' should create valid ISAN" do
      ismn = Istwox::ISAN.new "00000002B3C80000"
      ismn.should be
  end

  it "'0000-0002-B3C8-0000-3' should have root part '0000-0002-B3C8'" do
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3"
      ismn.root_with_hyphen.should  == '0000-0002-B3C8'
  end
  
  it "'0000-0002-B3C8-0000-3' should have episode part '0000'" do
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3"
      ismn.episode.should == '0000'
  end
  
  it "'0000-0002-B3C8-0000-3' should have check digit '3'" do
      isan = Istwox::ISAN.new "00000002B3C800003"
      isan.check_digit_isan.should == '3'
  end

  it "'00000002B3C80000' should have root part '0000-0002-B3C8'" do
      ismn = Istwox::ISAN.new "00000002B3C80000"
      ismn.root_with_hyphen.should == '0000-0002-B3C8'
  end
  
  it "'00000002B3C80000' should have episode part '0000'" do
      ismn = Istwox::ISAN.new "00000002B3C80000"
      ismn.episode.should == '0000'
  end
  
  it "'00000002B3C80000' should have check digit '3'" do
      isan = Istwox::ISAN.new "00000002B3C80000"
      isan.check_digit_isan.should == '3'
  end

end


describe Istwox::VISAN, "Test International Standard Audiovisual Number (VISAN)" do
  it "'ISAN: 0000-0000-DDB0-0069-Q-0000-0000-X' should create valid ISAN" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-0069-Q-0000-0000-X"
      isan.should be
  end

  it "'ISAN: 0000-0000-DDB0-006A-O-0000-0000-2' should create valid ISAN" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006A-O-0000-0000-2"
      isan.should be
  end

  it "'ISAN: 0000-0000-DDB0-006B-M-0000-0000-8' should create valid ISAN" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006B-M-0000-0000-8"
      isan.should be
  end
  
  it "'ISAN: 0000-0000-DDB0-0069-Q-0000-0000-X' should have first check digit Q" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-0069-Q-0000-0000-X"
      isan.check_digit_isan.should == 'Q'
  end

  it "'ISAN: 0000-0000-DDB0-006A-O-0000-0000-2' should have first check digit O" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006A-O-0000-0000-2"
      isan.check_digit_isan.should == 'O'
  end

  it "'ISAN: 0000-0000-DDB0-006B-M-0000-0000-8' should have first check digit M" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006B-M-0000-0000-8"
      isan.check_digit_isan.should == 'M'
  end
  
  it "'0000-0000-DDB0-0069-0000-0000' should have first check digit Q" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-0069-0000-0000"
      isan.check_digit_isan.should == 'Q'
  end

  it "'ISAN: 0000-0000-DDB0-006A-0000-0000' should have first check digit O" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006A-0000-0000"
      isan.check_digit_isan.should == 'O'
  end

  it "'0000-0000-DDB0-006B-0000-0000' should have first check digit M" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006B-0000-0000"
      isan.check_digit_isan.should == 'M'
  end

  it "'ISAN: 0000-0000-DDB0-0069-Q-0000-0000-X' should have second check digit X" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-0069-Q-0000-0000-X"
      isan.check_digit_visan.should == 'X'
  end

  it "'ISAN: 0000-0000-DDB0-006A-O-0000-0000-2' should have second check digit 2" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006A-O-0000-0000-2"
      isan.check_digit_visan.should == '2'
  end

  it "'ISAN: 0000-0000-DDB0-006B-M-0000-0000-8' should have second check digit 8" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006B-M-0000-0000-8"
      isan.check_digit_visan.should == '8'
  end

  it "'0000-0000-DDB0-0069-0000-0000' should have second check digit X" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-0069-0000-0000"
      isan.check_digit_visan.should == 'X'
  end

  it "'0000-0000-DDB0-006A-0000-0000' should have second check digit 2" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006A-0000-0000"
      isan.check_digit_visan.should == '2'
  end

  it "'0000-0000-DDB0-006B-0000-0000' should have second check digit 8" do
      isan = Istwox::VISAN.new "0000-0000-DDB0-006B-0000-0000"
      isan.check_digit_visan.should == '8'
  end




  it "'ISAN: 0000-0002-B3C8-0000-3-0000-0000-S' should create valid ISAN" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.should be
  end
  
  it "'00000002B3C80000300000000S' should create valid ISAN" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.should be
  end
  
  it "'0000-0002-B3C8-0000-3-0000-0000-S' should create printed format '0000-0002-B3C8-0000-3-0000-0000-S'" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.to_s.should == 'ISAN: 0000-0002-B3C8-0000-3-0000-0000-S'
  end
  
  it "'00000002B3C80000300000000S' should create printed format '0000-0002-B3C8-0000-3-0000-0000-S'" do
      isan = Istwox::VISAN.new "00000002B3C80000300000000S"
      isan.to_s.should == 'ISAN: 0000-0002-B3C8-0000-3-0000-0000-S'
  end
  
  it "'00000002B3C80000300000000' should create printed format '0000-0002-B3C8-0000-3-0000-0000-S'" do
      isan = Istwox::VISAN.new "00000002B3C80000300000000"
      isan.to_s.should == 'ISAN: 0000-0002-B3C8-0000-3-0000-0000-S'
  end
  
  it "'00000002B3C8000000000000' should create printed format '0000-0002-B3C8-0000-3-0000-0000-S'" do
      isan = Istwox::VISAN.new "00000002B3C8000000000000"
      isan.to_s.should == 'ISAN: 0000-0002-B3C8-0000-3-0000-0000-S'
  end

  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have root part with hyphen '0000-0002-B3C8'" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.root_with_hyphen.should  eq('0000-0002-B3C8')
  end
  
  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have root part without hyphen '00000002B3C8'" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.root.should  eq('00000002B3C8')
  end
  
  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have episode part '0000'" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.episode.should eq('0000')
  end
  
  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have version part with hyphen '0000-0000'" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.version_with_hyphen.should eq('0000-0000')
  end
  
  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have version part without hyphen '00000000'" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.version.should eq('00000000')
  end

  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have first check digit '3'" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.check_digit_isan.should eq('3')
  end

  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have second check digit 'S'" do
      isan = Istwox::VISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      isan.check_digit_visan.should eq('S')
  end
end
