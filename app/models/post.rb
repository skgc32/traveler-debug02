class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :location, presence: true, length: { maximum: 15 }
  validates :text, presence: true, length: { maximum: 195 }
  validates :image, presence: true

  enum status: { published: 0, draft: 1 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end