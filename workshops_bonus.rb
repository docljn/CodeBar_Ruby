class Member
  def initialize(full_name)
    @full_name = full_name
  end
  def full_name
    @full_name
  end
end

class Student < Member
  def initialize(full_name, about)
    super(full_name)
    @about = about
  end
  def about
    @about
  end
end



class Coach < Member
  attr_accessor :bio, :skills
  def initialize(full_name, bio)
    super(full_name)
    @bio = bio
    @skills = []
  end
  def add_skill(skill)
    @skills << skill
  end
end



class Workshop
  attr_accessor :date, :venue_name, :participants, :coaches, :students
  def initialize(date, venue_name)
    @date = date
    @venue_name = venue_name
    @participants =[]
    @coaches =[]
    @students =[]
  end
  def add_participant(member)
    @participants << member
  end



  def print_details
    puts "Workshop - #{@date} - #{@venue_name}"
    #this gives me an array of each instnce of the student class
    #and an array of each instance of the coach class.
    @participants.each do |participant|
      if participant.is_a?(Coach)
        @coaches << participant
      else participant.is_a?(Student)
        @students << participant
      end
    end
    #output the names and bios of each student.
    puts ""
    puts "Students"
    print_students
    #output the names and bios of each coach, and their skills
    puts ""
    puts "Coaches"
  end

  private
  def print_students
    student_counter = 1
    @students.each do |student|
      puts "#{student_counter}. \t#{student.full_name} - #{student.about}"
      student_counter += 1
    end
  end

  def print_coaches
    coach_counter = 1
    @coaches.each do |coach|
      puts "#{coach_counter}. \t#{coach.full_name} - #{coach.skills * ", "} \n\t#{coach.bio}"
      coach_counter += 1
    end
  end
end


#start required program and output here
workshop = Workshop.new("12/03/2014", "Shutl")

jane = Student.new("Jane Doe", "I am trying to learn programming and need some help")
lena = Student.new("Lena Smith", "I am really excited about learning to program!")
vicky = Coach.new("Vicky Ruby", "I want to help people learn coding.")
vicky.add_skill("HTML")
vicky.add_skill("JavaScript")
nicole = Coach.new("Nicole McMillan", "I have been programming for 5 years in Ruby and want to spread the love.")
nicole.add_skill("Ruby")

workshop.add_participant(jane)
workshop.add_participant(lena)
workshop.add_participant(vicky)
workshop.add_participant(nicole)

workshop.print_details
