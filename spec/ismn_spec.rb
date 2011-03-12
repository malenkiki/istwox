# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

describe Istwox::ISMN, "Test International Standard Music Number" do

  it "'979-0-060-11561' should create valid ISMN" do
      ismn = Istwox::ISMN.new "979-0-060-11561"
      ismn.should be
  end
  
  it "'' should have check digit = " do
      pending
      ismn = Istwox::ISMN.new ""
      ismn.check_digit.should eq()
  end
  
  it "'' should create ISMN having check digit = " do
      pending
      ismn = Istwox::ISMN.new ""
      ismn.check_digit.should eq()
  end
  
  it "'979-0-2600-0043-8' should create EAN code 9790260000438" do
      #pending "Some issues with extract_code, see ISSN too to change something about that"
      ismn = Istwox::ISMN.new "979-0-2600-0043-8"
      ismn.to_s.should eq("9790260000438")
  end
  
  it "'' should create EAN code " do
      pending "Some issu with extract_code, see ISSN too to change something about that"
      ismn = Istwox::ISMN.new ""
      ismn.to_s.should eq("")
  end
  
  it "'' should have GS1 prefix '979'" do
      pending
      ismn = Istwox::ISMN.new ""
      ismn.gs1_prefix.should eq("")
  end
  
  it "'' should have publisher = ''" do
      pending
      ismn = Istwox::ISMN.new ""
      ismn.pubisher.should eq("")
  end

  it "'' should have item = ''" do
      pending
      ismn = Istwox::ISMN.new ""
      ismn.item.should eq("")
  end
end


