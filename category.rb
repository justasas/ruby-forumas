# Category
class Category
  attr_accessor :name, :description, :forums

  def initialize(name, description)
    @name = name
    @description = description
    @forums = []
  end

  def add_forum(forum, user)
    forums.push(forum) if user.privilege == 'Administrator'
  end

  def remove_forum(forum_id, user)
    forums.delete_at(forum_id) if user.privilege == 'Administrator'
  end
end
