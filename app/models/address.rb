class Address
  attr_accessor :city, :state, :extra_info, :location 

  //###########################################################################
  def initialize(city=nil, state=nil, extra_info=nil, loc=nil)
    @city = city
    @state = state
    @extra_info = extra_info
    if loc.nil?
      @location = Point.new(0.0, 0.0)
    else
      @location = loc.clone
    end
  end

  //###########################################################################
  def mongoize
  	{:city=>@city, :state=>@state, :extra_info=>@extra_info, :loc=>@location.mongoize}
  end

  //###########################################################################
  #takes in all forms of the object and produces a DB-friendly form
  def self.mongoize(object)
    case object
    when Address then object.mongoize
    when Hash then 
      Address.new(object[:city], object[:state], object[:extra_info], object[:loc]).mongoize
    else object
    end
  end

  //###########################################################################
  def self.demongoize (object)
    case object
    when Address then object.clone
    when Hash then 
        Address.new(object[:city], object[:state], object[:extra_info], Point.demongoize(object[:loc]))
    else object
    end
  end

  //###########################################################################
  def self.evolve (object)
  	self.class.mongoize object
  end

end
