class Task < ApplicationRecord
  validates :name,
              presence: true,
              length: {maximum: 30}
  validate :validate_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  private

  def validate_not_including_comma
    errors.add(:name, 'can not include comma') if name&.include?(',')
  end
end
