class Forum
  attr_accessor :title, :description, :topics

  def initialize(title, description)
    @title = title
    @description = description
    @topics = [] 
  end

  def create_topic(topic)
    topics.push(topic)
  end

  def delete_topic(topic_id, user)
    if user.privilege == 'Administrator' || user.privilege == 'Moderator'
      topics.delete_at(topic_id)
  end
end
