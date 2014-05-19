class LeaderboardController < ApplicationController
  def index
  	@users = User.all.select {|u| u.selections.present?} 
  end
end
