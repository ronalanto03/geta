module ServicesHelper

	def self.random_location_from_given_pos(location, distance)
		distanceInMeter = distance
        directionInDegrees = rand(0 ... 360)

        lat = location[0]
        long = location[1]

        radDirection = directionInDegrees * Math::PI / 180

        dx = distanceInMeter * Math::cos(radDirection) 
        dy = distanceInMeter * Math::sin(radDirection)

        radLat = lat  * Math::PI / 180

        deltaLongitude = dx/(111320 * Math::cos(radLat))
        deltaLatitude = dy/110540                   

        endLat = lat + deltaLatitude
        endLong = long + deltaLongitude

        return [endLat, endLong]
	end
end
