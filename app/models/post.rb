class Post < ApplicationRecord
	attachment :image
	belongs_to :user

	has_many :tags
 	has_many :hashtags, through: :tags
	has_many :favorites, dependent: :destroy
	has_many :notificatuons, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	after_create do
    #1.controller側でcreateしたTweetを取得
    post = Post.find_by(id: self.id)
    #2.正規表現を用いて、Tweetのtext内から『#○○○』の文字列を検出
    hashtags  = self.text.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    #3.mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
    hashtags.uniq.map do |t|
      tag = Hashtag.find_or_create_by(hashname: t.downcase.delete('#'))
      post.hashtags << tag
    end
  end

  def create_notification_by(current_user)
    notification = current_user.active_notification.new(
      post_id: id,
      visited_id: user_id,
      action: "favorite"
      )
    notification.save if notification.valid?
  end

  def create_notification_follow!(current_user)
    temp = Notification.where([["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notification.new(
        visited_id: id,
        action: 'follow'
        )
      notification.save if  notification.valid?
    end
  end
  

end
