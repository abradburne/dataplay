class Datafile < ApplicationRecord
  belongs_to :dataset
  has_one_attached :attachment

  validates :filename, presence: true

  before_validation :set_filename, :set_metadata

  def file?
    attachment.attached?
  end

  def short_content_type
    content_type&.split('/')&.first
  end

  private

  def set_filename
    if attachment.attached? && filename.blank?
      self.filename = attachment.filename
    end
  end

  def set_metadata
    if attachment.attached?
      self.content_type = attachment.content_type
      self.byte_size = attachment.byte_size
      self.metadata = attachment.metadata
    end
  end
end
