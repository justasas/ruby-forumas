# Topic
class Topic
  attr_accessor :title, :owner, :replies
  def initialize(title, replies = [])
    @title = title
    @owner = replies.first.owner
    @owner.topics.push self
    # owner.topics.push(self)
    @replies = replies
  end

  def addReply(reply)
    replies.push reply
  end
end
