class HomesController < ApplicationController
	
	def top
    @post = Post.order(updated_at: :desc).limit(4)
	end

	def about
	end
end
