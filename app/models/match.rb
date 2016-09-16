class Match < ActiveRecord::Base
  belongs_to :player1, class_name: :User, foreign_key: 'player1_id'
  belongs_to :player2, class_name: :User, foreign_key: 'player2_id'

  validates_presence_of :player2_score,:player1_score,:player1_id,:player2_id,:date_played
  validate :players_are_not_the_same
  validate :winner_min_score
  validate :two_point_margin
  after_validation :set_winner
  before_create :update_players_score

  def tie?
    player1_score == player2_score
  end

  def winner
    return nil if player2_score.blank?
    if player1_score > player2_score
      player1
    else
      player2
    end
  end

  def losser
    if player1_score < player2_score
      player1
    else
      player2
    end
  end

  def score_by_id(id)
    if id == player1_id
      return player1_score
    elsif id == player2_id
      return player2_score
    end
    nil
  end

  private

  def players_are_not_the_same
    errors.add(:player2_id, "players can't be the same") if player1_id == player2_id
  end

  def set_winner
    return if player2_score.nil?
    if player1_score > player2_score
      self.winner_id = player1_id
    elsif player2_score > player1_score
      self.winner_id = player2_id
    end
  end

  def winner_min_score
    winner_score = score_by_id(winner.try(:id))
    return if winner_score.nil?
    return if winner_score >= 21
    msg = "winner player should have at least 21 points to finish the game"
    errors.add(max_points_player_attribute, msg)
  end

  def max_points_player_attribute
    if winner == player1
      return :player1_score
    end
    :player2_score
  end

  def two_point_margin
    return if player2_score.nil?
    errors.add(max_points_player_attribute, "margin should be at least of two points") if (player1_score - player2_score).abs < 2
  end

  def update_players_score
    calc = Pingpong::ScoreCalculator.new(self)
    calc.exec
  end
end
