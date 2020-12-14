module NotificationHelper

	 def notification_form(notification)
      @visitor = notification.visitor
      @comment = nil
      your_post = link_to 'あなたの投稿', post_path(notification), style:"font-weight: bold;"
      #notification.actionがfollowかlikeかcommentか
      case notification.action
        when "follow" then
          tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
        when "favorite" then
          tag.a(notification.visitor.name, href:user_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_post_path(notification.podt_id), style:"font-weight: bold;")+"にいいねしました"
        
      end
    end
    
    def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
    end
end
