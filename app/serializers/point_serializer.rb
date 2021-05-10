class PointSerializer < ActiveModel::Serializer
  attributes :name, :latitude, :longitude

  def longitude
    object.encode_lonlat['coordinates'].first.round(5)
  end

  def latitude
    object.encode_lonlat['coordinates'].last.round(5)
  end
end
