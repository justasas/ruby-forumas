require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Category do
  let(:category) { Category.new 'title', 'description' }
  let(:forum) { Forum.new 'title', 'description' }
  let(:user) { Account.new 'admin', 'pass1', 'email@email.com', 1993 }

  describe '#add_forum' do
    it 'should add forum to the end of forums list when
      user is administrator' do
      category.add_forum(forum)
      expect(category.forums.last).to eq forum
    end

    it 'should not add forum to the end of forums list when user
      is not administrator' do
      category.add_forum(forum)
      expect(category.forums.last).to be empty
    end
  end

  describe '#remove_forum' do
    it 'should remove forum from the forums list when user is administrator' do
      forum2 = Forum.new 'title2', 'desc'
      forum3 = Forum.new 'title3', 'desc'
      category.add_forum(forum)
      category.add_forum(forum2)
      category.add_forum(forum3)
      user.privilege = 'Administrator'
      category.remove_forum(1, user)
      expect(category.forums).to contain_exactly(forum, forum3)
    end

    it 'should not remove forum from the forums list when user
      is not administrator' do
      forum2 = Forum.new 'title2', 'desc'
      forum3 = Forum.new 'title3', 'desc'
      category.add_forum(forum)
      category.add_forum(forum2)
      category.add_forum(forum3)
      user.privilege = 'Administrator'
      category.remove_forum(1, user)
      expect(category.forums).to contain_exactly(forum, forum2, forum3)
    end
  end
end
