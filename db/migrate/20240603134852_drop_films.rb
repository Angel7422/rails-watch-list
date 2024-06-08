class DropFilms < ActiveRecord::Migration[7.1]
  def change
    drop_table :films
  end
end
