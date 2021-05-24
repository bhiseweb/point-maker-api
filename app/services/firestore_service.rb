# frozen_string_literal: true

require 'google/cloud/firestore'

class FirestoreService
  def call(reference)
    firestore = Google::Cloud::Firestore.new(
      project_id: Rails.root.join(ENV['FIRESTORE_DB']),
      credentials: Rails.root.join(ENV['GOOGLE_APPLICATION_CREDENTIALS'])
    )
    firestore.doc reference
  end
end
