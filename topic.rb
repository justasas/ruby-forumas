# Topic
class Topic
  attr_accessor :title, :owner, :replies
  def initialize(title, owner, replies = [])
    @title = title
    @owner = owner
    @replies = replies
  end
end
