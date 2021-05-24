# frozen_string_literal: true

module RgeoGeojson
  extend ActiveSupport::Concern

  def decode_lonlat(lonlat)
    RGeo::GeoJSON.decode(lonlat)
  end

  def encode_lonlat(lonlat)
    RGeo::GeoJSON.encode(lonlat)
  end
end
