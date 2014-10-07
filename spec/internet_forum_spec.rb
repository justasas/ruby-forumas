require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Internet_forum do
  let(:internet_forum) { Internet_forum.new 'title', 'description', 'admin' }
  let(:user) { Account.new 'john', 'pass1', 'email@email.com', 1993 }
  let(:user2) { Account.new 'admin', 'pass', 'email', 1993 }
  let(:reply) { Reply.new(owner, 'text') }

  it 'should have correct title' do
    expect(internet_forum.title).to eq 'title'
  end

  it 'should have correct description' do
    expect(internet_forum.description).to eq 'description'
  end

  it 'should have correct admin' do
    expect(internet_forum.admin).to eq 'admin'
  end

  describe '#register_new_user' do
    it 'adds new user to forum when user with same name is not already registered' do
      internet_forum.register_new_user(user)
      expect(internet_forum.accounts.last).to eq user
    end

    it 'does not add new accout when user with same name is already registered' do
      user3 = Account.new 'john', 'password', 'email@mail.com', 1993 }
      internet_forum.register_new_user(user)
      internet_forum.register_new_user(user3)
      expect(internet_forum.accounts).to end_with user3
    end
  end
end
