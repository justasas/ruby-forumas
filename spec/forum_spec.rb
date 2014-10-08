require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Forum do
  let(:forum) { Forum.new 'title', 'description' }
  let(:topic) { Topic.new 'title' }
  let(:user) { Account.new 'admin', 'pass1', 'email@email.com', 1993 }

  describe '#add_topic' do
    it 'should add topic to the end of topics list'
      forum.add_topic(topic)
      expect(forums.topics.last).to eq topic
    end
  end

  describe '#delete_topic' do
    it 'should remove topic from the topics list when user is administrator or moderator' do
      topic2 = Topic.new 'title2'
      topic3 = Topic.new 'title3'
      forum.add_topic(topic)
      forum.add_topic(topic2)
      forum.add_topic(topic3)
      forum.remove_topic(1, user)
      expect(forum.topics2).to contain_exactly(topic, topic3)
    end
  end
end
