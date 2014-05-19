module LeaderboardHelper
	def needs_selections?(user)
		user.selections.blank?
	end
end
