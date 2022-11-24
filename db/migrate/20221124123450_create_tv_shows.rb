class CreateTvShows < ActiveRecord::Migration[7.0]
  def change
    create_table :tv_shows do |t|
      t.string :title
      t.text :synopsis
      t.integer :year

      t.timestamps
    end
  end
end
