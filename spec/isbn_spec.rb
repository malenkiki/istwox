# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

describe Istwox::ISBN, "Test International Standard Book Number (ISBN-13)" do

  it "'978 2035 854377' should create valid ISBN" do
      isbn = Istwox::ISBN.new "978 2035 854377"
      isbn.should be
  end
  
  it "'978 2035 854377' should have check digit = 7" do
      isbn = Istwox::ISBN.new "978 2035 854377"
      isbn.check_digit.should eq(7)
  end
  
  it "'978 2035 85437' should create ISBN having check digit = 7" do
      isbn = Istwox::ISBN.new "978 2035 85437"
      isbn.check_digit.should eq(7)
  end
  
  it "'978 2035 85437' should create EAN code 9782035854377" do
      isbn = Istwox::ISBN.new "978 2035 85437"
      isbn.to_s.should eq("9782035854377")
  end
  
  it "'ISBN 978-2-03-585437-7' should create EAN code 9782035854377" do
      isbn = Istwox::ISBN.new "ISBN 978-2-03-585437-7"
      isbn.to_s.should eq("9782035854377")
  end
  
  it "'9782035854377' should have GS1 prefix '978'" do
      isbn = Istwox::ISBN.new "9782035854377"
      isbn.gs1_prefix.should eq("978")
  end
  
  it "'9782035854377' should have group identifier '2'" do
      isbn = Istwox::ISBN.new "9782035854377"
      isbn.group_identifier.should eq("2")
  end

  it "'9782035854377' should have publisher code and title '03585437'" do
      isbn = Istwox::ISBN.new "9782035854377"
      isbn.publisher_code_and_title.should eq("03585437")
  end
end

describe Istwox::ISBN10, "Test International Standard Book Number (old format ISBN-10)" do

  it "'978 2035 854377' should create valid ISBN" do
      pending
      isbn = Istwox::ISBN10.new "978 2035 854377"
      isbn.should be
  end
end

