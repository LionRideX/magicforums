class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :votes
  mount_uploader :image, ImageUploader
  
  def total_votes
    votes.pluck(:value).sum

  end
end
