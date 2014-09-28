# Account
class Account
  attr_accessor :id, :pass, :email, :birth_year
  def initialize(id, pass, email, birth_year)
    @pass = pass
    @id = id
    @email = email
    @birth_year = birth_year
  end

  # def display
  # puts "Account id = #{@id}, password = #{@pass},
  # email = #{@email} and birth year = #{@birth_year}"
  # end
end
