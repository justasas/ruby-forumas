# Reply
class Reply
  # @@last_id = 0
  attr_accessor :owner, :Id, :text, :time, :quotes, :last_edit_owner,
                :last_edit_time
  def initialize(owner, text, *quotes)
    # @id = last_id
    # last_id.inc
    @owner = owner
    owner.replies.push(self)
    @time = Time.new
    @text = text
    @quotes = quotes
    @last_edit_time = nil
    @last_edit_owner = nil
  end
end
