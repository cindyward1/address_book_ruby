class Address

  def initialize (input_street_address)
    @street_address = input_street_address
  end

  def street_address
    @street_address
  end

  def change_street_address(new_address)
    @street_address = new_address
  end

end
