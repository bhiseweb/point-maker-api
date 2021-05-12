require 'google/cloud/firestore'

class FirestoreService
  def call(reference)
    firestore = Google::Cloud::Firestore.new(
      project_id: 'mapbox-points-db',
      credentials: Rails.root.join(ENV['GOOGLE_APPLICATION_CREDENTIALS'])
    )
    firestore.doc reference
  end
end
