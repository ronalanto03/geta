class Service
  include Mongoid::Document
  include Geocoder::Model::Mongoid


  field :name, type: String
  field :description, type: String
  field :category, type: String
  field :status, type: Mongoid::Boolean
  # field :address, type: String
  field :coordinates, :type => Array


  # geocoded_by :address               # can also be an IP address
  # after_validation :geocode          # auto-fetch coordinates

  # reverse_geocoded_by :coordinates
  # after_validation :reverse_geocode  # auto-fetch address

  belongs_to :user, dependent: :destroy




  # after_validation :reverse_geocode, if: ->(obj){ obj.coordinates.present? }
  # after_validation :geocode, if: ->(obj){ obj.address.present? }

end
