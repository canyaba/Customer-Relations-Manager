class Customer < ApplicationRecord
  has_one_attached :image

  validates :full_name, presence: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  scope :alphabetized, -> { order(:full_name) }
  scope :missing_email, -> { where(email_address: [nil, ""]) }

  def self.ransackable_attributes(_auth_object = nil)
    ["id", "full_name", "email_address", "phone_number", "notes", "created_at", "updated_at"]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
