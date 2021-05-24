# frozen_string_literal: true

require 'google/cloud/firestore'

class FirestoreService
  def initialize
    @firestore = Google::Cloud::Firestore.new(
      project_id: Rails.root.join(ENV['FIRESTORE_DB']),
      credentials: Rails.root.join(ENV['GOOGLE_APPLICATION_CREDENTIALS'])
    )
  end

  attr_reader :firestore

  def doc(reference)
    firestore.doc(reference)
  end

  def set(attributes)
    doc.set(attributes)
  end

  def delete
    doc.delete
  end
end
