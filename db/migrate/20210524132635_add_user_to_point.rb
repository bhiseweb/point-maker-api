class AddUserToPoint < ActiveRecord::Migration[6.1]
  def change
    add_reference :points, :user, foreign_key: true, index: true
  end
end
