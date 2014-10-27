class AddViewedOnMovie < ActiveRecord::Migration
  def change
    add_column :movies, :viewed, :boolean, default: false
  end
end
