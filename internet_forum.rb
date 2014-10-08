# InternetForum
class Internet_forum
  attr_accessor :title, :description, :admin, :accounts
  def initialize(title, description, admin)
    @title = title
    @description = description
    @accounts = []
    @admin = admin
  end

  def register_new_user(user)
    accounts.each { |account| return false if account.name == user.name }
    accounts.push user
  end

  def log_in(name, pass)
    found_account = nil
    accounts.each do |account|
      found_account = account if account.name == name
      return 'user does not exist' if found_account == nil
      return 'password is not correct' if found_account.pass != pass
      return found_account.name
    end
  end
end
