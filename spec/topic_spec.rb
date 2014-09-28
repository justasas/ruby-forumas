require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Topic do
  let(:owner) { Account.new 'john', 'pass1', 'email@email.com', 1993, topics = [], replies = [] }
  let(:reply) { Reply.new(owner, 'text') }
  let(:topic) { Topic.new 'title', [reply] }

  it 'should have title' do
    expect(topic.title == 'title')
  end

  it 'should have owner' do
    expect(topic.owner == owner)
    # expect(topic.replies.first.owner == owner)
  end

  it "should have creator's reply when created" do
    # expect(topic.replies.first.owner.replies.last == topic.replies.first)
    expect(topic.owner.replies.last == topic.replies.first)
  end

  describe '#addReply' do
    it 'adds the reply to replies list' do
      topic.addReply(reply)
      expect(topic.replies.last == reply)
    end
  end
end
