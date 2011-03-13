# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

describe Istwox::ISMN, "Test International Standard Music Number" do

  it "'979-0-060-11561-5' should create valid ISMN" do
      ismn = Istwox::ISMN.new "979-0-060-11561-5"
      ismn.should be
  end
  
  it "'979-0-060-11561' should have check digit = 5" do
      ismn = Istwox::ISMN.new "979-0-060-11561"
      ismn.check_digit.should eq(5)
  end
  
  it "'979-0-060-11561-5' should create ISMN having check digit = 5" do
      ismn = Istwox::ISMN.new "979-0-060-11561-5"
      ismn.check_digit.should eq(5)
  end
  
  it "'979-0-2600-0043-8' should create EAN code 9790260000438" do
      ismn = Istwox::ISMN.new "979-0-2600-0043-8"
      ismn.to_s.should eq("9790260000438")
  end
  
  it "'979-0-2600-0043' should create EAN code 9790260000438" do
      ismn = Istwox::ISMN.new "979-0-2600-0043"
      ismn.to_s.should eq("9790260000438")
  end
  
  
  it "'979-0-2600-0043-8' should have GS1 prefix '979'" do
      ismn = Istwox::ISMN.new "979-0-2600-0043-8"
      ismn.gs1_prefix.should eq("979")
  end
  
  it "'979-0-2600-0043-8' should have publisher = '2600'" do
      ismn = Istwox::ISMN.new "979-0-2600-0043-8"
      ismn.publisher.should eq("2600")
  end
  
  it "'979-0-060-11561-5' should have publisher = '060'" do
      ismn = Istwox::ISMN.new "979-0-060-11561-5"
      ismn.publisher.should eq("060")
  end
  
  it "'' should have publisher = ''" do
      pending "Have test for each publisher range and test for out of range."
      ismn = Istwox::ISMN.new "979-0-2600-0043-8"
      ismn.publisher.should eq("2600")
  end

  it "'979-0-2600-0043-8' should have item = '0043'" do
      ismn = Istwox::ISMN.new "979-0-2600-0043-8"
      ismn.item.should eq("0043")
  end
  
  it "'979-0-060-11561-5' should have item = '11561'" do
      ismn = Istwox::ISMN.new "979-0-060-11561-5"
      ismn.item.should eq("11561")
  end
end


