# Topic
class Topic
  attr_accessor :id, :title, :owner, :replies, :ratings,
                :users_who_rated
  def initialize(title, replies = [])
    @title = title
    @replies = replies
    @owner = replies.first.owner
    @owner.topics.push self
    @users_who_rated = []
    @ratings = []
  end

  def add_reply(reply, *quotes)
    reply.quotes = quotes
    replies.push reply
  end

  def remove_reply(user, id)
    user.privilege == 'Administrator' ? replies.delete_at(id) : nil
  end

  def edit_reply(user, id, text)
    return false if user.replies.index(replies[id]).nil? && user.privilege !=
      'Administrator'
    replies[id].text = text
    replies[id].last_edit_owner = user
    replies[id].last_edit_time = Time.new
  end

  def add_rating(user, stars)
    return false if stars < 1 || stars > 5
    ind = @users_who_rated.index(user)
    if ind
      ratings[ind] = stars
      return
    end
    ratings.push(stars)
    users_who_rated.push(user)
  end
end
