module Pingpong
  class ScoreCalculator 
    def initialize(match)
      @match = match
      @player1,@player2 = [match.winner,match.losser]
    end

    def exec
      set_points
      update_scores
    end

    def set_points
      if @match.tie?
        return set_points_tie
      end
      set_points_no_tie(@player1,@player2)
    end

    def set_points_no_tie(winner, losser)
      puts "weights &&&&&&&&&&&&&&&&&&&&&&&"
      puts losser.weight
      puts winner.weight
      @player1_points = 10 * losser.weight
      @player2_points = 5 * winner.weight
    end

    def set_points_tie
      @player1_points = 8 * player2.weight
      @player2_points = 8 * player1.weight
    end

    def update_scores
      @player1.update_score!(@player1.score + @player1_points)
      @player2.update_score!(@player2.score + @player2_points)
    end
  end
end
