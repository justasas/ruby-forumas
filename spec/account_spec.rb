require 'simplecov'
SimpleCov.start

require 'spec_helper'

RSpec::Matchers.define :have_a_correct_email_syntax do
  match do |email|
    email =~ /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/
  end
end

describe Account do
  let(:user1) { Account.new 'admin', 'pass1', 'email@email.com', 1993 }
  let(:user2) { Account.new 'john', 'pass1', 'email@email.com', 1993 }
  let(:reply1) { Reply.new(user2, 'text1') }
  let(:reply2) { Reply.new(user2, 'text2') }
  let(:topic) { Topic.new 'title', [reply1, reply2] }

  it "should have owner's name" do
    expect(user2.name).to eq 'john'
  end

  it "should have account owner's pass" do
    expect(user2.pass).to eq 'pass1'
  end

  it "should have account owner's email" do
    expect(user2.email).to eq 'email@email.com'
  end

  it "should have account owner's birth year" do
    expect(user2.birth_year).to eq 1993
  end

  it "should have correct email syntax" do
    expect(user1.email).to have_a_correct_email_syntax
  end

  # its(:name) { should eql "John" }
  # its(:pass) { should eql "pass1" }
  # its(:email) { should eql "email@email.com" }
  # its(:birth_year) { should eql 1993 }
end
