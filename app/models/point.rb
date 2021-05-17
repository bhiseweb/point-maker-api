class Point < ApplicationRecord
  belongs_to :creator, class_name: :User, foreign_key: :creator_id

  before_save :decode_lonlat
  after_save :add_to_firestore
  after_destroy :delete_from_firestore

  attr_accessor :latitude, :longitude

  def decode_lonlat
    lonlat = {type: "Point", coordinates: [longitude, latitude]}.as_json
    decoded = RGeo::GeoJSON.decode(lonlat)
    self.lonlat = decoded
  end

  def encode_lonlat
    RGeo::GeoJSON.encode(lonlat)
  end

  def add_to_firestore
    doc_ref = FirestoreService.new.call "points/#{self.id}"
    doc_ref.set(
      {
        name: self.name,
        latitude: self.latitude,
        longitude: self.longitude
      }
    )
  end

  def delete_from_firestore
    doc_ref = FirestoreService.new.call "points/#{self.id}"
    doc_ref.delete
  end
end
