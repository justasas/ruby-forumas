require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Account do
  let(:account) { Account.new 'john', 'pass1', 'email@email.com', 1993 }

  it "should have account owner's id" do
    account.id.should == 'john'
  end

  it "should have account owner's pass" do
    account.pass.should == 'pass1'
  end

  it "should have account owner's email" do
    account.email.should == 'email@email.com'
  end

  it "should have account owner's birth year" do
    account.birth_year.should == 1993
  end

  # its(:name) { should eql "John" }
  # its(:pass) { should eql "pass1" }
  # its(:email) { should eql "email@email.com" }
  # its(:birth_year) { should eql 1993 }
end
