# frozen_string_literal: true

require 'google/cloud/firestore'

class FirestoreService
  def initialize
    @firestore = Google::Cloud::Firestore.new(
      project_id: Rails.root.join(Rails.application.credentials.firestore_db),
      credentials: Rails.root.join(Rails.application.credentials.google_application_credentials)
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
