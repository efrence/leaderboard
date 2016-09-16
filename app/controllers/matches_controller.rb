class MatchesController < ApplicationController 
  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    @match.player1_id = current_user.id
    if @match.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def match_params
    params.required(:match).permit(:player2_id,:player1_score,:player2_score,:date_played)
  end
end
