class Users::LeaderboardController < ApplicationController 
  def index
    @users = User.all
  end
end

