# frozen_string_literal: true

class CreatePoints < ActiveRecord::Migration[6.1]
  def change
    create_table :points do |t|
      t.string :name
      t.st_point :lonlat, geographic: true
      t.timestamps
    end
  end
end
