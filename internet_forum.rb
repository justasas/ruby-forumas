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
    return false if !accounts.index(user).nil?
    accounts.push user
  end
end
