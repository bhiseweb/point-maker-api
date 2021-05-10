require "google/cloud/firestore"
class Point < ApplicationRecord

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
    doc_ref = firestore_init.doc "points/#{self.id}"
    doc_ref.set(
      {
        name: self.name,
        latitude: self.latitude,
        longitude: self.longitude
      }
    )
  end

  def delete_from_firestore
    doc_ref = firestore.doc "#{collection_path}/#{self.id}"
    doc_ref.delete
  end

  private
  def firestore_init
    @_firestore ||= Google::Cloud::Firestore.new(project_id: "leena-mapbox", 
      credentials: Rails.root.join('leena-mapbox-313306-dee8ce3a2cb9.json'))
  end
end
