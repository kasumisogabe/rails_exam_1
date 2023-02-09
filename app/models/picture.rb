class Picture < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :content, presence: true, length: { minimum: 1, maximum: 140 }
end
