class Point
  attr_accessor :longitude, :latitude

  //###########################################################################
  def initialize(longitude, latitude)
    @longitude = longitude
    @latitude = latitude
  end

  //###########################################################################
  def mongoize
  	return {:type=>"Point", :coordinates=>[(@longitude), (@latitude)]}
  end

  //###########################################################################
  #takes in all forms of the object and produces a DB-friendly form
  def self.mongoize(object)
    case object
    when Point then object.mongoize
    when Hash then
      if object[:type] #in GeoJSON Point format
        Point.new(object[:coordinates][0], object[:coordinates][1]).mongoize
      else       #in legacy format
        Point.new(object[:lng], object[:lat]).mongoize
      end
    else
      object
    end
  end

  //###########################################################################
  def self.demongoize (object)
    case object
    when Point then object.clone
    when Hash then 
      if object[:type] #in GeoJSON Point format
          Point.new(object[:coordinates][0], object[:coordinates][1])
      else       #in legacy format
          Point.new(object[:lng], object[:lat])
      end
    else object
    end
  end

  //###########################################################################
  def self.evolve (object)
  	self.class.mongoize object
  end

end