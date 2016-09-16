class CreateLeaderboards < ActiveRecord::Migration
  def change
    create_table :leaderboards do |t|
      t.string :email
      t.integer :wins
      t.integer :losses
      t.integer :games_played
      t.integer :score

      t.timestamps null: false
    end
  end
end
