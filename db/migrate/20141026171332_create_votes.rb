class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :movie
      t.boolean :value

      t.timestamps
    end
  end
end
