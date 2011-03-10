# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

describe Istwox::ISSN, "Test International Standard Serial Number implementation" do

  it "'03952037' should create valid ISSN" do
      issn = Istwox::ISSN.new "03952037"
      issn.should be
  end
  
  it "'2111403X' should create valid ISSN" do
      issn = Istwox::ISSN.new "2111403X"
      issn.should be
  end

  it "'ISSN03952037' should create valid ISSN" do
      issn = Istwox::ISSN.new "ISSN03952037"
      issn.should be
  end
  
  it "'ISSN2111403X' should create valid ISSN" do
      issn = Istwox::ISSN.new "ISSN2111403X"
      issn.should be
  end
  
  it "'ISSN 0395-2037' should create valid ISSN" do
      issn = Istwox::ISSN.new "ISSN 0395-2037"
      issn.should be
  end
  
  it "'ISSN 2111-403X' should create valid ISSN" do
      issn = Istwox::ISSN.new "ISSN 2111-403X"
      issn.should be
  end
  
  it "'ISSN n° 0395-2037' should create valid ISSN" do
      issn = Istwox::ISSN.new "ISSN n° 0395-2037"
      issn.should be
  end
  
  it "'ISSN n° 2111-403X' should create valid ISSN" do
      issn = Istwox::ISSN.new "ISSN n° 2111-403X"
      issn.should be
  end
  
  it "03952031 should raise an ArgumentError exception" do
      expect { Istwox::ISSN.new "03952031" }.to raise_error ArgumentError
  end

  it "2112403X should raise an ArgumentError exception" do
      expect { Istwox::ISSN.new "2112403X" }.to raise_error ArgumentError
  end
  
  it "103952031 should raise an ArgumentError exception" do
      expect { Istwox::ISSN.new "03952031" }.to raise_error ArgumentError
  end

  it "12112403X should raise an ArgumentError exception" do
      expect { Istwox::ISSN.new "2112403X" }.to raise_error ArgumentError
  end
  
  it "3952031 should raise an ArgumentError exception" do
      expect { Istwox::ISSN.new "03952031" }.to raise_error ArgumentError
  end

  it "112403X should raise an ArgumentError exception" do
      expect { Istwox::ISSN.new "2112403X" }.to raise_error ArgumentError
  end

  it "'03952037' should return the string ISSN 0395-2037" do
      issn = Istwox::ISSN.new "03952037"
      issn.to_s.should eq('ISSN 0395-2037')
  end

  it "'2111403X' should return the string ISSN 2111-403X" do
      issn = Istwox::ISSN.new "2111403X"
      issn.to_s.should eq('ISSN 2111-403X')
  end

  it "'ISSN03952037' should return the string ISSN 0395-2037" do
      issn = Istwox::ISSN.new "ISSN03952037"
      issn.to_s.should eq('ISSN 0395-2037')
  end

  it "'ISSN2111403X' should return the string ISSN 2111-403X" do
      issn = Istwox::ISSN.new "ISSN2111403X"
      issn.to_s.should eq('ISSN 2111-403X')
  end

  it "'ISSN n°0395-2037' should return the string ISSN 0395-2037" do
      issn = Istwox::ISSN.new "ISSN n°0395-2037"
      issn.to_s.should eq('ISSN 0395-2037')
  end

  it "'ISSN n°2111-403X' should return the string ISSN 2111-403X" do
      issn = Istwox::ISSN.new "ISSN n°2111-403X"
      issn.to_s.should eq('ISSN 2111-403X')
  end

  it "first part code of 03952037 must have 4 digits" do
      issn = Istwox::ISSN.new "03952037"
      issn.first_part.should have_exactly(4).items
  end
  
  it "second part code of 03952037 must have 4 digits" do
      issn = Istwox::ISSN.new "03952037"
      issn.second_part.should have_exactly(4).items
  end
  
  it "second part code of 2111403X must have 4 digits" do
      issn = Istwox::ISSN.new "2111403X"
      issn.second_part.should have_exactly(4).items
  end
end

