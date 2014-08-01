class Email

  def initialize (input_email_address)
    @email_address = input_email_address
  end

  def email_address
    @email_address
  end

  def change_email_address(new_email)
    @email_address = new_email
  end

end
