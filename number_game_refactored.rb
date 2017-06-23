#who is playing?

print "What is your name? "
player_name ||= "Human"
player_name = gets.chomp.to_s.capitalize


#choosing what type of maths question you want
game_choice_hash = {1 => "addition", 2 => "multiplication", 3 => "subtraction", 4 => "division", 5 => "random maths"}
puts "Please choose a game:"
game_choice_hash.each do |choice,type|
  puts "Type #{choice} for #{type}."
end
game_choice ||= 0
game_choice = gets.chomp.to_i
# null entry or anything that isn't a number returns "0" if gets.to_i is used.

#can't do this as a one-line boolean as there are two steps in the else stage.
if game_choice == 0
  puts "I'm sorry, I didn't understand your choice of game."
else
  print "How many #{game_choice_hash[game_choice]} questions would you like today, #{player_name}? "
  number = gets.to_i
end


#actually run the game here, including setting the start time.
#setting default values
turns = 0
correct = 0
wrong = 0
start = Time.now
game_choice_original = 0

#Think about creating methods for each set of calcs?

#Hopefully this will allow a random choice as a 5th option?


if game_choice > 0

  while turns < number
    turns = turns + 1

    #addition
    if game_choice == 1
      x = Random.rand(3..12)
      y = Random.rand(3..12)
      print "#{x} + #{y} = "
      input_answer = gets.to_i
      if input_answer == x+y
        puts "Right!"
        correct = correct + 1
      else
        puts "Sorry, that's not right.  The right answer is #{x+y}."
        wrong = wrong + 1
      end
      if game_choice_original == 5
        game_choice = 5
      end

      #multiplication
    elsif game_choice == 2
      x = Random.rand(3..12)
      y = Random.rand(3..12)
      print "#{x} x #{y} = "
      input_answer = gets.to_i
      if input_answer == x*y
        puts "Right!"
        correct = correct + 1
      else
        puts "Sorry, that's not right.  The right answer is #{x*y}."
        wrong = wrong + 1
      end
      if game_choice_original == 5
        game_choice = 5
      end

      #subtraction
    elsif game_choice == 3
      x = Random.rand(2..12)
      y = Random.rand(2..12)
      print "#{x+y} - #{y} = "
      input_answer = gets.to_i
      if input_answer == x
        puts "Right!"
        correct = correct + 1
      else
        puts "Sorry, that's not right.  The right answer is #{x}."
        wrong = wrong + 1
      end
      if game_choice_original == 5
        game_choice = 5
      end

      #division
    elsif game_choice == 4
      x = Random.rand(2..12)
      y = Random.rand(2..12)
      print "#{x*y} / #{y} = "
      input_answer = gets.to_i
      if input_answer == x
        puts "Right!"
        correct = correct + 1
      else
        puts "Sorry, that's not right.  The right answer is #{x}."
        wrong = wrong + 1
      end
      if game_choice_original == 5
        game_choice = 5
      end

    elsif game_choice == 5
      game_choice_original = 5
      game_choice = Random.rand(1..4)
      turns = turns -1

    else
      print ""
    end
  end


  if turns == 0
    score = 0
    #i.e. if no number of questions was chosen and hence no game was played.
    puts "Sorry you didn't want to play this time."
    puts "Goodbye"
  else
    score = 100*correct/(number)
    length = Time.now - start
    average = length/number
    points = (correct*1000/length).round
    puts "Right #{correct}; Wrong #{wrong}; Score #{score}%; Points #{points}."
    puts "Average time #{average.round} seconds per question."
  end

  #result
  # end of game output to screen

  #experimenting with case instead of if/elsif/else/end -
  #didn't work as it's an argument not a statement - not easy to read either.



  if score <50
    puts "You will improve with practice."
  elsif score >=80
    puts "Well done, #{player_name}, Maths Genius!"
  else puts "Well done, #{player_name}!"
  end

  #OK so I need to read the file, sort by points, and output the top 5.
  #I don't think I'm going to try and overwrite the previous score of the player at this stage
  #Way too complicated.
  #instead, to limit the file size, save top x scores when I overwrite the file and save it

  #write the newest points score into the csv file - file closes automatically due to block.
  File.open("scorecard.txt","a") { |line| line.puts "#{player_name},#{points}" }
  #creates an empty array
  scores = []

  #Reads the entire file based on individual lines and returns those lines in an array.
  File.readlines("scorecard.txt").each do |line|
    scores << line.chomp.split(",")
  end

  #trying to sort the file based on points, which will be at position 1 in the array
  #sorting in descending order

  scores.sort! do |a,b|
    b[1] <=> a[1]
  end

  leaderboard = scores.first(5)
  puts "Leaderboard"
  
  leaderboard = leaderboard.join(": ")
  puts leaderboard



  #then output the first five items in the array of arrays to give the leaderboard

  #puts "Leaderboard"
  #scores.each do |a,b|
  #  puts scores[a,b]
  #end



  #how to do something for a given line of a file (using the index?) i.e. how to output the first five
  #File.open(local_fname, "r") do |file|
  # file.readlines.each_with_index do |line, idx|
  #    puts line if idx(0..5)
  # end
  #end


else
  puts "Goodbye."
end
