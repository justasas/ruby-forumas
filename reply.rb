# Reply
class Reply
  attr_accessor :owner, :text, :time
  def initialize(owner, text)
    @owner = owner
    owner.replies.push(self)
    @time = Time.new
    @text = text
  end
end
