class Celcius

  def initialize(day, temp=0)
    @temp = temp
    @day = day
  end

  attr_accessor :temp , :day 

  def input(d)
    print "Please enter the temperature on #{d}: "
    c = gets.chomp.to_i
  end

  def fahrenheit(c)
    f = (c * 1.8 + 32).round
    "#{f} degrees F"
  end

  def celcius(c)
    "#{c} degrees C"
  end

  def output_for_array(d,c,f)
    "#{d}\t| #{c}\t| #{f}"
  end

end

week = ["Mon", "Tues", "Weds", "Thurs", "Fri", "Sat", "Sun"]
results ||=[]
week.each do |d|
  day = Celcius.new(d)
  temp = day.input(d)
  f = day.fahrenheit(temp)
  c = day.celcius(temp)
  results << day.output_for_array(d,c,f)
end

results.each do |r|
  puts r
end
