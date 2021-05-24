# frozen_string_literal: true

class Point < ApplicationRecord
  include RgeoGeojson

  belongs_to :creator, class_name: :User, foreign_key: :creator_id

  before_save :set_lonlat
  after_save :add_to_firestore
  after_destroy :delete_from_firestore

  scope :with_name, ->(name) { where('name ilike ?', "%#{name}%") }

  attr_accessor :latitude, :longitude

  def set_lonlat
    lonlat = { type: 'Point', coordinates: [longitude, latitude] }.as_json
    self.lonlat = decode_lonlat(lonlat)
  end

  def add_to_firestore
    attributes = {
                   name: name,
                   latitude: latitude,
                   longitude: longitude
                 }

    firestore_doc.set(attributes)
  end

  def delete_from_firestore
    firestore_doc.delete
  end

  def firestore_doc
    FirestoreService.new.doc("points/#{id}")
  end
end
