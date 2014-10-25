# InternetForum
class Internet_forum
  attr_accessor :title, :description, :accounts, :categories
  def initialize(title, description)
    @title = title
    @description = description
    @accounts = []
    @categories = []
  end

  def register_new_user(user)
    accounts.each { |account| return false if account.name == user.name }
    user.privilege = 'Administrator' if user.name == @admin
    accounts.push user
  end

  def remove_user(user_id, user)
    accounts.delete_at(user_id) if user.privilege == 'Administrator' 
    accounts.delete_at(user_id) if accounts[user_id].name == user.name
  end

  def log_in(name, pass)
    found_account = nil
    accounts.each do |account|
      found_account = account if account.name == name
    end
    return 'user does not exist' if found_account == nil
    return 'password is not correct' if found_account.pass != pass
    return found_account
  end

  def add_category(category, user) 
    categories.each { |cat| return false if category.name == cat.name }
    categories.push(category) if user.privilege.eql? "Administrator"
  end

  def remove_category(category_id, user)
    categories.delete_at(category_id) if user.privilege == 'Administrator'
  end
end
