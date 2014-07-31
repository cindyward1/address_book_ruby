require "./lib/contact"
require "./lib/phone"
require "./lib/email"
require "./lib/address"

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
      puts "Main options:"
      puts "   m = return to main menu (this menu)"
      puts "   x = exit the program"
      puts "Contact operations:"
      puts "   l = list all information about a contact"
      puts "   e = edit information about this contact"
      puts "  -c = delete this contact"
      puts "\n"
      option = gets.chomp
      if option == "l"
        list_phones
        list_emails
        list_addresses
      elsif option == "e"
        edit_contact_information
      elsif option == "-c"
        delete_contact
      elsif option == "m"
        main_menu
      elsif option == "x"
        puts "End of Address Book application"
        puts  "\n"
        exit
      else
        puts "Invalid option, please try again"
        puts "\n"
      end
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
  puts "Enter an e-mail address for your contact #{Contact.by_index(@current_contact_index).contact_name}"
  email_address = gets.chomp
  new_email = Email.new(email_address)
  Contact.by_index(@current_contact_index).add_email(new_email)
end

def list_emails
  if Contact.by_index(@current_contact_index).email.empty?
    puts "No email addresses for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    puts "\n"
  else
    puts "Email addresses for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    Contact.by_index(@current_contact_index).email.each_with_index do |email, index|
      puts "#{index+1}. #{email.email_address}"
    end
    puts "\n"
  end
end

def add_address
  puts "Enter a street address for your contact #{Contact.by_index(@current_contact_index).contact_name}"
  street_address = gets.chomp
  new_address = Address.new(street_address)
  Contact.by_index(@current_contact_index).add_address(new_address)
end

def list_addresses
  if Contact.by_index(@current_contact_index).address.empty?
    puts "No street addresses for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    puts "\n"
  else
    puts "Street addresses for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    Contact.by_index(@current_contact_index).address.each_with_index do |address, index|
      puts "#{index+1}. #{address.street_address}"
    end
    puts "\n"
  end
end

def edit_contact_information
end

def delete_contact
  puts "Enter YES if you REALLY want to delete #{Contact.by_index(@current_contact_index).contact_name}"
  option = ""
  option = gets.chomp
  if option == "YES"
    puts "Contact #{Contact.by_index(@current_contact_index).contact_name} deleted"
    puts "\n"
    Contact.all.delete_at(@current_contact_index)
  else
    puts "Nothing was deleted"
    puts "\n"
  end
end

address_book
