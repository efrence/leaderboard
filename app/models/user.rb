class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :matches

  def weight
    if first_time?
      return 1.0
    end
    [0.1, (games_won.to_f / (games_played.nonzero? || 1))].max
  end

  def games_played
    Match.where(:player1_id => self.id).count + Match.where(:player2_id => self.id).count 
  end

  def games_won
    Match.where(:winner_id => self.id).count 
  end

  def update_score!(new_score)
    self.update!(:score => new_score)
  end

  def first_time?
    games_played == 0
  end
end
