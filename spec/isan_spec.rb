# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

# Some examples: Inception: 0000-0002-B3C8-0000-3-0000-0000-S
# Stargate Atlantis - Season 1 - Disc 2: 0000-0000-DDB0-0069-Q-0000-0000-X
# Stargate Atlantis - Season 1 - Disc 3: 0000-0000-DDB0-006A-O-0000-0000-2
# Stargate Atlantis - Season 1 - Disc 4: 0000-0000-DDB0-006B-M-0000-0000-8
# see http://www.finseth.com/isan.html
describe Istwox::ISAN, "Test International Standard Audiovisual Number" do

  it "'0000-0002-B3C8-0000-3-0000-0000-S' should create valid ISAN" do
      pending "ISAN must be implement first"
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      ismn.should be
  end

  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have root part '0000-0002-B3C8'" do
      pending "ISAN must be implement first"
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      ismn.root.should  eq('0000-0002-B3C8')
  end
  
  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have episode part '0000'" do
      pending "ISAN must be implement first"
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      ismn.episode.should eq('0000')
  end
  
  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have version part '0000-0000'" do
      pending "ISAN must be implement first"
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      ismn.version.should eq('0000-0000')
  end

  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have first check digit '3'" do
      pending "ISAN must be implement first"
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      ismn.first_check_digit.should eq('3')
  end

  it "'0000-0002-B3C8-0000-3-0000-0000-S' should have second check digit 'S'" do
      pending "ISAN must be implement first"
      ismn = Istwox::ISAN.new "0000-0002-B3C8-0000-3-0000-0000-S"
      ismn.second_check_digit.should eq('S')
  end
end


