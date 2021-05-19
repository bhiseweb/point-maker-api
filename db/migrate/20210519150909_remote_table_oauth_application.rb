class RemoteTableOauthApplication < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key(:oauth_access_tokens, column: :application_id)
    remove_index :oauth_applications, :uid
    drop_table :oauth_applications
    change_column_null :oauth_access_tokens, :application_id, true
  end
end
