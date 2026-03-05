class Customer < ApplicationRecord

  # Allow ActiveAdmin search
  def self.ransackable_attributes(auth_object = nil)
    ["id", "full_name", "email_address", "phone_number", "notes", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["image_attachment", "image_blob"]
  end

end