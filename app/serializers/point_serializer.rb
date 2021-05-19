class PointSerializer < ActiveModel::Serializer
  attributes :name, :latitude, :longitude

  def longitude
    coordinates.first.round(5)
  end

  def latitude
    coordinates.last.round(5)
  end

  private

  def coordinates
    object.encode_lonlat(object.lonlat)['coordinates']
  end
end
