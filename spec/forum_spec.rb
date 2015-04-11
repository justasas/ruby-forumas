require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Forum do
  let(:forum) { Forum.new 'title', 'description' }
  let(:topic) { Topic.new 'title' }
  let(:user) { Account.new 'admin', 'pass1', 'email@email.com', 1993 }
  let(:reply) { Reply.new(user, 'text1') }
  let(:topic) { Topic.new 'title', [reply] }

  describe '#create_topic' do
    it 'should add topic to the end of topics list' do
      forum.create_topic(topic)
      expect(forum.topics.last).to eq topic
    end
    it 'should not add topic to the end of topics list' do
      forum.create_topic(topic)
      expect(forum.topics).to_be empty
    end
  end

  describe '#delete_topic' do
    it 'should remove topic from the topics list when user is administrator
      or moderator' do
      topic2 = Topic.new 'title2', [reply]
      topic3 = Topic.new 'title3', [reply]
      forum.create_topic(topic)
      forum.create_topic(topic2)
      forum.create_topic(topic3)
      user.privilege = 'Administrator'
      forum.delete_topic(1, user)
      expect(forum.topics).to contain_exactly(topic, topic3)
    end

    it 'should not remove topic from the topics list when user is not an
      administrator or moderator' do
      topic2 = Topic.new 'title2', [reply]
      topic3 = Topic.new 'title3', [reply]
      forum.create_topic(topic)
      forum.create_topic(topic2)
      forum.create_topic(topic3)
      user.privilege = 'Administrator'
      forum.delete_topic(1, user)
      expect(forum.topics).to contain_exactly(topic, topic2, topic3)
    end
  end
end
