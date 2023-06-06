class NotificationMailer < ApplicationMailer
  def new_post_notification(post)
    @post = post
    User.all.each do |user|
      mail to: User.all.pluck(user.email), subject: 'New post created'
    end
  end
end
