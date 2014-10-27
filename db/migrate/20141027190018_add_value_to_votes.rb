class AddValueToVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :value
    add_column :votes, :value, :integer
  end
end
