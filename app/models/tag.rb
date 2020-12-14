class Tag < ApplicationRecord
	belongs_to :post
  	belongs_to :hashtag
end
