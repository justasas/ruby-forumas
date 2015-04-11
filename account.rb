# Account
class Account
  # @@last_id = 0
  attr_accessor :id, :name, :pass, :email, :birth_year, :topics, :replies,
                :privilege
  def initialize(name, pass, email, birth_year)
    # @id = @@last_id
    # @Id == 1?@privilege = 'Administrator' : @privilege = nil
    @privilege = ''
    # @@last_id += 1
    @pass = pass
    @name = name
    @email = email
    @birth_year = birth_year
    @topics = []
    @replies = []
  end

  # def add_privilege_for_user(privilege, user)
  #  return false if @privilege.not_eql? 'Administrator'
  #  user.privileges.push(privilege)
  # end
end
