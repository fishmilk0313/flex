class Hashtag < ApplicationRecord
	validates :hashname, presence: true, length: {maximum:99}
  	has_many :tags
  	has_many :posts, through: :tags
	
end
