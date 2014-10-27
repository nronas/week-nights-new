class AddMissingColumnsOnMovie < ActiveRecord::Migration
  def change
    add_column :movies, :rating, :float
    rename_column :movies, :img_url, :image_url
  end
end
