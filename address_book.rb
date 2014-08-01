require "./lib/contact"
require "./lib/phone"
require "./lib/email"
require "./lib/address"

def main_menu

  @current_contact_index = 0
  @current_phone_index = 0
  @current_email_index = 0
  @current_address_index = 0

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
      main_menu
    else
      main_menu
    end
  end
end

def add_contact
  puts "Enter a contact name for your new contact"
  contact_name = ""
  contact_name = gets.chomp
  if contact_name.length > 0
    Contact.new(contact_name).add
    @current_contact_index = Contact.all.length-1
  else
    puts "No contact name entered, try again"
    puts "\n"
    add_contact
  end
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
    puts  "Enter the index of your desired current contact"
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
      option = gets.chomp.downcase
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
        list_contacts
      end
    end
  end
end

def add_phone
  puts "Enter a phone number for your contact #{Contact.by_index(@current_contact_index).contact_name}"
  phone_number = gets.chomp
  if phone_number.length > 0
    new_phone = Phone.new(phone_number)
    Contact.by_index(@current_contact_index).add_phone(new_phone)
  else
    puts "No phone number added, try again"
    puts "\n"
    add_phone
  end
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
    puts "Would you like to edit phone number information for #{Contact.by_index(@current_contact_index).contact_name}"
    puts "Enter 'y' for yes or any other character for no"
    answer = gets.chomp.downcase
    if answer == "y"
      change_phone_information
    end
  end
end

def add_email
  puts "Enter an e-mail address for your contact #{Contact.by_index(@current_contact_index).contact_name}"
  email_address = gets.chomp
  if email_address.length > 0
    new_email = Email.new(email_address)
    Contact.by_index(@current_contact_index).add_email(new_email)
  else
    puts "No email address entered, try again"
    puts "\n"
    add_email
  end
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
  if street_address.length > 0
    new_address = Address.new(street_address)
    Contact.by_index(@current_contact_index).add_address(new_address)
  else
    puts "No street address entered, try again"
    puts "\n"
    add_address
  end
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
  list_phones
  list_emails
  list_addresses

  puts "Main options:"
  puts "   m = return to main menu (this menu)"
  puts "   x = exit the program"
  puts "Contact operations:"
  puts "  ~p = change phone number information"
  puts "  ~e = change email address information"
  puts "  ~s = change street address information"
  puts "\n"

  option = gets.chomp.downcase
  if option == "~p"
    change_phone_information
  elsif option == "~e"
    change_email_information
  elsif option == "~s"
    change_address_information
  elsif option == "m"
    main_menu
  elsif option == "x"
    puts "End of Address Book application"
    puts  "\n"
    exit
  else
    puts "Invalid option, try again"
    edit_contact_information
  end
end

def change_phone_information
  if Contact.by_index(@current_contact_index).phone.empty?
    puts "No phone numbers for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    puts "\n"
  else
    puts "Please enter the index of the phone number you'd like to change"
    puts "\n"
    @current_phone_index = gets.chomp.to_i-1
    if @current_phone_index > Contact.by_index(@current_contact_index).phone.length ||
                              @current_phone_index <=0
      puts "Invalid phone number chosen, please try again"
      puts "\n"
      list_phones
    else
      puts "Main options:"
      puts "   m = return to main menu (this menu)"
      puts "   x = exit the program"
      puts "Phone number operations:"
      puts "  -p = delete phone number information"
      puts "  ~p = change phone number information"
      puts "\n"
      option = gets.chomp.downcase
      if option == "-p"
        puts "#{Contact.by_index(@current_contact_index).phone[@current_phone_index].phone_number} deleted"
        Contact.by_index(@current_contact_index).phone.delete_at(@current_phone_index)
      elsif option == "~p"
        puts "Please enter the new phone number for this entry"
        puts "\n"
        new_phone = gets.chomp
        Contact.by_index(@current_contact_index).phone[@current_phone_index].change_phone_number(new_phone)
      elsif option == "m"
        main_menu
      elsif option == "x"
        puts "End of Address Book application"
        puts "\n"
        exit
      else
        puts "Invalid option entered, try again"
        puts "\n"
        change_phone_information
      end
    end
  end
end

def change_email_information
  if Contact.by_index(@current_contact_index).email.empty?
    puts "No email addresses for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    puts "\n"
  else
    puts "Please enter the index of the email address you'd like to change"
    puts "\n"
    @current_email_index = gets.chomp.to_i-1
    if @current_email_index > Contact.by_index(@current_contact_index).email.length ||
                              @current_email_index <=0
      puts "Invalid email address chosen, please try again"
      puts "\n"
      list_emails
    else
      puts "Main options:"
      puts "   m = return to main menu (this menu)"
      puts "   x = exit the program"
      puts "Phone number operations:"
      puts "  -e = delete email address information"
      puts "  ~e = change email address information"
      puts "\n"
      option = gets.chomp.downcase
      if option == "-e"
        puts "#{Contact.by_index(@current_contact_index).email[@current_email_index].email_address} deleted"
        Contact.by_index(@current_contact_index).email.delete_at(@current_email_index)
      elsif option == "~e"
        puts "Please enter the new email address for this entry"
        puts "\n"
        new_email = gets.chomp
        Contact.by_index(@current_contact_index).email[@current_email_index].change_email_address(new_email)
      elsif option == "m"
        main_menu
      elsif option == "x"
        puts "End of Address Book application"
        puts "\n"
        exit
      else
        puts "Invalid option entered, try again"
        puts "\n"
        change_email_information
      end
    end
  end
end

def change_address_information
if Contact.by_index(@current_contact_index).address.empty?
    puts "No street addresses for your contact #{Contact.by_index(@current_contact_index).contact_name}"
    puts "\n"
  else
    puts "Please enter the index of the street address you'd like to change"
    puts "\n"
    @current_address_index = gets.chomp.to_i-1
    if @current_address_index > Contact.by_index(@current_contact_index).address.length ||
                              @current_address_index <=0
      puts "Invalid street address chosen, please try again"
      puts "\n"
      list_addresses
    else
      puts "Main options:"
      puts "   m = return to main menu (this menu)"
      puts "   x = exit the program"
      puts "Phone number operations:"
      puts "  -s = delete street address information"
      puts "  ~s = change street address information"
      puts "\n"
      option = gets.chomp.downcase
      if option == "-s"
        puts "#{Contact.by_index(@current_contact_index).address[@current_address_index].street_address} deleted"
        Contact.by_index(@current_contact_index).address.delete_at(@current_address_index)
      elsif option == "~s"
        puts "Please enter the new street address for this entry"
        puts "\n"
        new_address = gets.chomp
        Contact.by_index(@current_contact_index).address[@current_address_index].change_street_address(new_address)
      elsif option == "m"
        main_menu
      elsif option == "x"
        puts "End of Address Book application"
        puts "\n"
        exit
      else
        puts "Invalid option entered, try again"
        puts "\n"
        change_address_information
      end
    end
  end
end

def delete_contact
  puts "Enter 'YES' if you REALLY want to delete #{Contact.by_index(@current_contact_index).contact_name}"
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

main_menu
