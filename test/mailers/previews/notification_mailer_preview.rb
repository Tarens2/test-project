# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def new_post_notification
    NotificationMailer.new_post_notification(Post.first)
  end
end
