class Tutorial
  def initialize(name,type,diff)
    @name = name
    @type = type
    @diff = diff
    @diff_hash = {:easy=>1, :medium=>2, :hard=>3, :advanced=>4, :expert=>5}
  end

  attr_accessor :name, :type, :diff

  def compare_diff
    comparison_value = @diff_hash[diff]
  end


  #this looks at the tutorial.is_harder_than rather than the (tutorial)
  def is_harder_than?(t2)
    result = compare_diff
    t2_result = @diff_hash[t2.diff]
    if type == t2.type
      if result>t2_result
        puts "true"
      else
        puts "false"
      end
    else puts "You cannot compare a Ruby with a JavaScript tutorial."
    end
  end

end


tutorial1 = Tutorial.new("Object Oriented Ruby", :ruby, :medium)
tutorial2 = Tutorial.new("Introduction to JavaScript", :javascript, :easy)
tutorial3 = Tutorial.new("HTTP Requests, AJAX and APIs", :javascript, :medium)

tutorial1.is_harder_than?(tutorial2)
tutorial2.is_harder_than?(tutorial1)
tutorial2.is_harder_than?(tutorial3)
tutorial3.is_harder_than?(tutorial2)
