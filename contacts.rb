require 'pstore'
contacts ||= PStore.new("contacts.pstore")
run = true
puts "Welcome to your contact list:"
while(run) do
  #our main program code will go here
  options_hash = {1 => "add a new contact", 2 => "find a contact's birthday", 3 => "find everyone who was born on a given date", 4 => "list all contacts", 5 => "to exit"}
  puts "Please choose an option:"
  options_hash.each do |choice,type|
  puts "Type #{choice} to #{type}."
  end
  option ||= 5
  option = gets.chomp.to_i

  if option == 1
    #Capture the name and date of birth and store the information
    print "Contact name: "
    name = gets.chomp #creates a string
    #what if the person is already in the list?
    #ask if they want to change the data?
    print "Date of birth (as MM/DD/YYYY): "
    dob = gets.chomp #creates a string
    dob_contact = contacts.transaction { contacts.fetch(name, "blank") }
    puts "#{name} is already in your contact list, born on #{dob_contact}" unless dob_contact == "blank"
    contacts.transaction do
      contacts[name] = dob
      print "You said that #{name} was born on #{dob}.  Do you want to update your contacts? y/n "
      confirm = gets.chomp
      if confirm == "n"
        contacts.abort
      else
        contacts.commit
      end
    end

  elsif option == 2
      #Request the full name and print out the date of birth
    print "Contact name: "
    name = gets.chomp
    value = contacts.transaction { contacts.fetch(name, "Sorry that isn't in your list.") }
    puts value
    puts ""

  elsif option == 3
#      print "Birthday (DD/MM/YYYY)"
#      dob = gets.chomp
#    #••is it possible to search by birthday?
#    #iterate of the pstore to create a new hash called all_contacts
#    contacts.transaction do
#      all_contacts = {}
#      contacts.roots.each do |name|
#        all_contacts[name] = contacts[name]
#      end
#      today = all_contacts.select {|name,bday| contacts[name] == dob }
#      today.each do |name,bday|
#        puts "#{name}, #{bday}"
#      end
#      puts ""
#    end
#    #that works, but only if year is included


#  elsif option == 10
    print "Birthday (DD/MM)"
    dob = gets.chomp
    #the same new hash with the contents of the pstore file
    contacts.transaction do
      all_contacts = {}
      contacts.roots.each do |name|
        all_contacts[name] = contacts[name]
      end
      #slice the dob value to just 5 characters
      short_dob = {}
      all_contacts.each do |name,bday|
        short_dob[name] = (all_contacts[name].to_s).slice(0..4)
      end

      #new hash with only that day's birthdays
      today = short_dob.select {|name,bday| short_dob[name] == dob }
      puts "Born on #{dob}:"
      today.each {|name, bday| puts name}
      #yet another new hash with the full dob for those selected in 'today'
      today_with_year = all_contacts.select { |name, bday| name == (today[bday]) }
      today_with_year.each { |name,bday| puts "#{name}, #{bday}" }
      puts ""
    end

  elsif option == 4
    #list all contacts (alphabetically by first name)
    contacts.transaction do
      contacts.roots.sort.each do |name|
        puts "#{name}, #{contacts[name]}"
      end
      puts ""
    end

    #**is it possible to split by space, sort by lastword, and then output it?


  elsif option == 5
    #Make the program exit by changing the value of the run variable.
    run = false
  else
    puts "\n**I'm sorry, I didn't understand your choice.** \n \n"
  end

  #Tips for this exercise
    #don’t forget to require pstore
    #to append values to a PStore key you must first initialise it, if it’s empty.
      #You can do that using lazy assignment ||= []
        #where if the object is empty, you first create an array so you can append values to it
    #use print instead of puts if you don’t want to output a new line at the end of your sentence
    #Can you think of ways to extend the program? Store and display more information about your contacts.
end
