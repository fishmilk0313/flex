class RelationshipsController < ApplicationController

	def create
		@user = User.find(params[:following_id])
		current_user.follow(@user)
		＃通知の作成
		@user.create_notification_follow!(current_user)
	end

	def destroy
		@user = User.find(params[:id])
		current_user.unfollow(@user)
	end
end
