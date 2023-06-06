class Post < ApplicationRecord
  validates :title, :body, :author, presence: true
end
