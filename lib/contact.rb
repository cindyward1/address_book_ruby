class Contact

  @@all_contacts = []

  def Contact.clear
    @@all_contacts = []
  end

  def Contact.by_index (index)
    @@all_contacts[index]
  end

  def Contact.all
    @@all_contacts
  end

  def add
    @@all_contacts << self
  end

  def initialize (contact_name)
    @contact_name = contact_name
    @phone = []
    @email = []
    @address = []
  end

  def contact_name
    @contact_name
  end

  def phone
    @phone
  end

  def email
    @email
  end

  def address
    @address
  end

  def add_phone(new_phone)
    @phone << new_phone
  end

  def add_email(new_email)
    @email << new_email
  end

  def add_address(new_address)
    @address << new_address
  end

end
