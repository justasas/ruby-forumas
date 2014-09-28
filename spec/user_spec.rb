require 'spec_helper'

describe User do
# http://betterspecs.org/#let
	before :each do
		@user = User.new "John", "pass1", "email@email.com", 1993
	end

	describe "#new" do
		it "takes three parameters and returns User object" do
			@user.should be_an_instance_of User
		end
	end

	describe "#id" do
		it "returns the correct id" do
			@user.id.should eql "first"
		end
	end

	describe "#pass" do
		it "returns the correct pass" do
			@user.pass.should eql "pass1"
		end
	end

	describe "#name" do
		it "returns the correct name" do
			@user.name.should eql "John"
		end
	end 

	describe "#email" do
		it "returns the correct email" do
			@user.email.should eql "email@email.com"
		end
	end		

	describe "#birth_year" do
		it "should return the correct birth year" do
			@user.birth_year.should eql 1993
		end
	end
end
