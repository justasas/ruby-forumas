# Category
class Category
  attr_accessor :title, :description, :forums

  def initialize(title, description)
    @title = title
    @description = description
    @forums = []
  end

  def add_forum(forum)
    forums.push(forum)
  end

  def remove_forum(forum_id, user)
    forums.delete_at(forum_id) if user.privilege == 'Administrator'
  end
end
