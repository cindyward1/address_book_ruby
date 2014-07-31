require "./lib/contact"
require "./lib/phone"

def address_book

  @current_contact_address = 0

  puts "Welcome to the Address Book application"
  option = ""

  while option != "x"
    puts "\n"
    puts "Please enter an option from the list below"
    puts "------------------------------------------"
    puts "Main options:"
    puts "   m = return to main menu (this menu)"
    puts "   x = exit the program"
    puts "Contact options:"
    puts "  +c = add a contact"
    puts "   c = list all contacts (can choose a current contact)"
    puts "Phone options:"
    puts "  +p = add a phone number for the current contact"
    puts "   p = list all phone numbers for the current contact (can delete or change a phone number)"
    puts "Email options:"
    puts "  +e = add an email address to the current contact"
    puts "   e = list all email addresses for the current contact (can delete or change an email address)"
    puts "Street address options:"
    puts "  +s = add a street address to the current contact"
    puts "   s = list all street addresses for the current contact (can delete or change a street address)"
    puts "\n"

    option = gets.chomp.downcase
    if option == "x"
      puts "End of Address Book application"
      puts  "\n"
      exit
    elsif option == "+c"
      add_contact
    elsif option == "c"
      list_contacts
    elsif option == "+p"
      add_phone
    elsif option == "p"
      list_phones
    elsif option == "+e"
      add_email
    elsif option == "e"
      list_emails
    elsif option == "+s"
      add_address
    elsif option == "s"
      list_addresses
    elsif option != "m"
      puts "Invalid option, please try again"
      puts "\n"
    end
  end
end

def add_contact
  puts "Enter a contact name for your new contact"
  contact_name = gets.chomp
  Contact.new(contact_name).add
  @current_contact_index = Contact.all.length-1
end

def list_contacts
  if Contact.all.empty?
    puts "No contacts in your address book"
  else
    puts "These are your current contacts"
    Contact.all.each_with_index do |contact, index|
      puts "#{index+1}. #{contact.contact_name}"
    end
    puts "\n"
    puts  "Enter the number of your desired current contact"
    @current_contact_index = gets.chomp.to_i
    if @current_contact_index > Contact.all.length || @current_contact_index <=0
      puts "Invalid contact number, please try again"
      puts "\n"
      list_contacts
    else
      @current_contact_index -= 1
      puts "Your current contact is now #{Contact.by_index(@current_contact_index).contact_name}"
      puts "\n"
    end
  end
end

def add_phone
  puts "Enter a phone number for your contact #{Contact.by_index(@current_contact_index).contact_name}"
  phone_number = gets.chomp
  new_phone = Phone.new(phone_number)
  Contact.by_index(@current_contact_index).add_phone(new_phone)
end

def list_phones
  if Contact.by_index(@current_contact_index).phone.empty?
    puts "No phone numbers for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    puts "\n"
  else
    puts "Phone numbers for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    Contact.by_index(@current_contact_index).phone.each_with_index do |phone, index|
      puts "#{index+1}. #{phone.phone_number}"
    end
    puts "\n"
  end
end

def add_email
end

def list_emails
end

def add_address
end

def list_addresses
end

address_book
