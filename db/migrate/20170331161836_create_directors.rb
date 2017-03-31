class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :names
      t.string :image
      t.integer :movie_id

      t.timestamps

    end
  end
end
