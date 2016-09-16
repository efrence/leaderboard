class AddDatePlayedToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :date_played, :datetime
  end 
end
