# -*- coding: utf-8 -*-
require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

describe Istwox::ISSN, "Test International Standard Serial Number implementation" do

  it "should create valid ISSN" do
      issn = Istwox::ISSN.new "03952037"
      issn.calculate_check_digit
      issn.is_valid?.should be_true
  end

end

