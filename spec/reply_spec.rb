require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Reply do
  let(:owner) { Account.new 'john', 'pass1', 'email@email.com', 1993 }
  let(:reply) { Reply.new('title', owner, 'text') }

  it 'should have title' do
    expect(reply.title == 'title')
  end

  it 'should have owner' do
    expect(reply.owner == owner)
  end

  it 'should have text' do
    expect(reply.text == 'text')
  end
end
