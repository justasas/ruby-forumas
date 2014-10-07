require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Internet_forum do
  let(:internet_forum) { Internet_forum.new 'title', 'description', 'admin' }
  let(:owner) { Account.new 'john', 'pass1', 'email@email.com', 1993 }
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

  describe '#registerNewUser' do
    internet_forum.register_new_user
  end
end
