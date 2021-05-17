class AddUserToPoints < ActiveRecord::Migration[6.1]
  def change
    add_reference :points, :creator, foreign_key: { to_table: :users }, index: true
  end
end
