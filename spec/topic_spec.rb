require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Topic do
  let(:user) { Account.new 'john', 'pass1', 'email@email.com', 1993 }
  let(:user2) { Account.new 'john', 'pass1', 'email@email.com', 1993 }
  let(:reply1) { Reply.new(user, 'text1') }
  let(:reply2) { Reply.new(user2, 'text2') }
  let(:topic) { Topic.new 'title', [reply1, reply2] }

  it 'should have title' do
    expect(topic.title == 'title')
  end

  it 'should have owner' do
    expect(topic.owner == user)
  end

  it "should have creator's reply when created" do
    expect(topic.owner.replies.last == topic.replies.first)
  end

  describe '#add_reply' do
    it 'should add reply to the end of replies array' do
      reply3 = Reply.new(user2, 'text3')
      topic.add_reply(reply3)
      expect(topic.replies.last).to eq reply3
    end

    it 'should add replies in chronological order' do
      reply3 = Reply.new(user2, 'text3')
      topic.add_reply(reply3)
      expect(topic.replies.last.time > topic.replies[1].time)
    end
  end

  describe '#add_rating' do
    it "should add user's rating if it doesn't exist" do
      topic.add_rating(user, 5)
      expect(topic.ratings[0]).to eq 5
    end

    it 'should not add new rating if it already exists' do
      topic.add_rating(user, 3)
      topic.add_rating(user, 3)
      expect(topic.ratings.size).to eq 1
    end

    it "should change user's rating if it already exists" do
      topic.add_rating(user, 5)
      topic.add_rating(user, 4)
      expect(topic.ratings[0]).to eq 4
    end

    it 'should return false if rating is less than 1 or bigger than 5' do
      expect(topic.add_rating(user, 8)).to eq false
    end
  end

  context 'when user with no privileges logged in' do
    describe '#remove_reply' do
      it 'should return nil' do
        receiver = topic.remove_reply(user, 1)
        expect(receiver).to eq(nil)
      end
    end

    describe '#edit_reply' do
      context 'when user wants to edit his own message' do
        it 'should change reply text field' do
          topic.edit_reply(user, 0, 'edited text field')
          expect(topic.replies[0].text).to eq 'edited text field'
        end
        it 'expects last_edit_time field to be > then time' do
          topic.edit_reply(user, 0, 'edited text field')
          expect(topic.replies[0].time < topic.replies[0].last_edit_time)
        end
      end

      context 'when user wants to edit other user message' do
        it 'should return false' do
          expect(topic.edit_reply(user, 1, 'edited text field')).to eq false
        end
      end
    end
  end

  context 'when admin or moderator logged in' do
    describe '#remove_reply' do
      it 'should remove object from replies array' do
        user.privilege = 'Administrator'
        topic.remove_reply(user, 1)
        expect(topic.replies.index(reply2)).to eq nil
      end
    end

    describe '#edit_reply' do
      it 'should change reply text field' do
        user.privilege = 'Administrator'
        topic.edit_reply(user, 1, 'edited text field')
        expect(topic.replies[1].text).to eq 'edited text field'
      end
      it 'expects last_edit_time field to be > then time' do
        user.privilege = 'Administrator'
        topic.edit_reply(user, 1, 'edited text field')
        expect(topic.replies[1].time < topic.replies[1].last_edit_time)
      end
    end
  end
end
