require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Account do
  let(:account) { Account.new 'john', 'pass1', 'email@email.com', 1993 }

  it "should have account owner's id" do
    expect(account.id) == 'john'
  end

  it "should have account owner's pass" do
    expect(account.pass) == 'pass1'
  end

  it "should have account owner's email" do
    expect(account.email) == 'email@email.com'
  end

  it "should have account owner's birth year" do
    expect(account.birth_year) == 1993
  end

  # its(:name) { should eql "John" }
  # its(:pass) { should eql "pass1" }
  # its(:email) { should eql "email@email.com" }
  # its(:birth_year) { should eql 1993 }
end
