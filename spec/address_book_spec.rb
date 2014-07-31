require "rspec"
require "contact"
require "phone"
require "email"
require "address"


describe(Phone) do

  it("is initialized with a phone number") do
    test_phone = Phone.new("800-555-1212")
    test_phone.should be_an_instance_of Phone
  end

  it("is initialized with a phone number") do
    test_phone = Phone.new("800-555-1212")
    test_phone.phone_number.should eq "800-555-1212"
  end

end


describe(Contact) do

  before do
    Contact.clear
  end

  it("is initialized") do
    test_contact = Contact.new("New Contact")
    test_contact.should be_an_instance_of Contact
  end

  it("is initialized with the contact name and empty phone, email and address lists") do
    test_contact = Contact.new("New Contact")
    test_contact.contact_name.should eq "New Contact"
    test_contact.phone.should eq []
    test_contact.email.should eq []
    test_contact.email.should eq []
  end

end
