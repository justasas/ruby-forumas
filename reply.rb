# Reply
class Reply
  attr_accessor :title, :owner, :text
  def initialize(title, owner, text)
    @title = title
    @owner = owner
    @time = Time.new
    @text = text
  end
end
