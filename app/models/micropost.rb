class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :video, VideoUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :video_size

  private

    # Validates the size of an uploaded video.
    def video_size
      if video.size > 15.megabytes
        errors.add(:video, "should be less than 15MB")
      end
    end
end
