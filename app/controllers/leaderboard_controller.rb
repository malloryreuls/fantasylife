class LeaderboardController < ApplicationController
  def index
  	@users = User.all
  	@selections = Selection.all
  end
end
