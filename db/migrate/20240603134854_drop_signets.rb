class DropSignets < ActiveRecord::Migration[7.1]
  def change
    drop_table :signets
  end
end
