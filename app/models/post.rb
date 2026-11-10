class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  validate :image_must_be_an_image

  private

  def image_must_be_an_image
    if image.attached? && !image.content_type.start_with?("image/")
      errors.add(:image, "must be an image")
    end
  end
end
