class RenameUserIdFromMovie < ActiveRecord::Migration
  def change
    rename_column :movies, :users_id, :user_id
  end
end
