class RemoveUserFromPoints < ActiveRecord::Migration[6.1]
  def change
    remove_reference :points, :creator, foreign_key: { to_table: :users }, index: true
  end
end
