require 'simplecov'
SimpleCov.start

require 'spec_helper'

describe Internet_forum do
  let(:internet_forum) { Internet_forum.new 'title', 'description' }
  let(:user) { Account.new 'john', 'pass1', 'email@email.com', 1993 }
  let(:category) { Category.new('name', 'description') }

  it 'should have correct title' do
    expect(internet_forum.title).to eq 'title'
  end

  it 'should have correct description' do
    expect(internet_forum.description).to eq 'description'
  end

  describe '#register_new_user' do
    it 'adds new user to forum when user with same name is not already registered' do
      internet_forum.register_new_user(user)
      expect(internet_forum.accounts.last).to eq user
    end

    it 'does not add new accout when user with same name is already registered' do
      user3 = Account.new 'john', 'password', 'email@mail.com', 1993
      internet_forum.register_new_user(user)
      internet_forum.register_new_user(user3)
      expect(internet_forum.accounts).not_to end_with user3
    end
  end

  describe '#log_in' do
    it 'should return correct account when log_in username and password are both correct' do
      internet_forum.register_new_user(user)
      expect(internet_forum.log_in('john','pass1')).to eq user
    end

    it 'should return "user does not exist" when log_in username does not exist in forum' do
      internet_forum.register_new_user(user)
      expect(internet_forum.log_in('name','pass1')).to eq 'user does not exist' 
    end

    it 'should return "password is not correct" when log_in password is not correct' do
      internet_forum.register_new_user(user)
      expect(internet_forum.log_in('john','incorrectpass')).to eq 'password is not correct' 
    end
  end

  describe '#add_category' do
    it 'should add category to the end of categories list when user is administrator' do
      user.privilege = 'Administrator'
      internet_forum.add_category(category, user)
      expect(internet_forum.categories.last).to eq category
    end

    it 'should not add category to the end of categories list when user is not administrator' do
      internet_forum.add_category(category, user)
      expect(internet_forum.categories).to be_empty
    end

    it 'should not add category if category with same name already exists when user is administrator' do
      user.privilege = 'Administrator'
      internet_forum.add_category(category, user)
      category2 = Category.new 'name', 'description'
      internet_forum.add_category(category2, user)
      expect(internet_forum.categories).to contain_exactly(category)
    end
  end

  describe '#remove_category' do
    it 'should remove category from the categories list when user is administrator' do
      category2 = Category.new 'name2', 'description'
      category3 = Category.new 'name3', 'description'
      user.privilege = 'Administrator'
      internet_forum.add_category(category, user)
      internet_forum.add_category(category2, user)
      internet_forum.add_category(category3, user)
      internet_forum.remove_category(1, user)
      expect(internet_forum.categories).to contain_exactly(category, category3)
    end

    it 'should not remove category to the categories list when user is not administrator' do
      category2 = Category.new 'name2', 'description'
      category3 = Category.new 'name3', 'description'
      user.privilege = 'Administrator'
      internet_forum.add_category(category, user)
      internet_forum.add_category(category2, user)
      internet_forum.add_category(category3, user)
      user.privilege = ''
      internet_forum.remove_category(1, user)
      expect(internet_forum.categories).to contain_exactly(category, category2, category3)
    end
  end

  describe '#remove_user' do
    it 'should remove account from the accounts list when current user is administrator' do
      user2 = Account.new 'john2', 'password', 'email@mail.com', 1993
      user3 = Account.new 'john3', 'password', 'email@mail.com', 1993
      internet_forum.register_new_user(user)
      internet_forum.register_new_user(user2)
      internet_forum.register_new_user(user3)
      user.privilege = 'Administrator'
      internet_forum.remove_user(1, user)
      expect(internet_forum.accounts).to contain_exactly(user, user3)
    end

    it 'should not remove account from the account list when user is not administrator' do
      user2 = Account.new 'john2', 'password', 'email@mail.com', 1993
      user3 = Account.new 'john3', 'password', 'email@mail.com', 1993
      internet_forum.register_new_user(user)
      internet_forum.register_new_user(user2)
      internet_forum.register_new_user(user3)
      user.privilege = ''
      internet_forum.remove_user(1, user)
      expect(internet_forum.accounts).to contain_exactly(user, user2, user3)
    end

    it 'should remove account if user tries to delete his own account' do
      user2 = Account.new 'john2', 'password', 'email@mail.com', 1993
      user3 = Account.new 'john3', 'password', 'email@mail.com', 1993
      internet_forum.register_new_user(user)
      internet_forum.register_new_user(user2)
      internet_forum.register_new_user(user3)
      internet_forum.remove_user(0, user)
      expect(internet_forum.accounts).to contain_exactly(user2, user3)
    end

    it 'should not remove account if user tries to delete his own account' do
      user2 = Account.new 'john2', 'password', 'email@mail.com', 1993
      user3 = Account.new 'john3', 'password', 'email@mail.com', 1993
      internet_forum.register_new_user(user)
      internet_forum.register_new_user(user2)
      internet_forum.register_new_user(user3)
      internet_forum.remove_user(0, user)
      expect(internet_forum.accounts).to contain_exactly(user, user2, user3)
    end
  end
end
