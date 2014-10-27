class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.references :users
      t.string :title
      t.string :img_url
      t.text :description

      t.timestamps
    end
  end
end
