require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Topic do
  let(:owner) { Account.new 'john', 'pass1', 'email@email.com', 1993 }
  let(:topic) { Topic.new 'title', @replie = Replie.new('title', owner, 'text') }

  it 'should have title' do
    expect(topic.title == 'title')
  end

  it 'should have owner' do
    expect(topic.owner == owner)
  end
end