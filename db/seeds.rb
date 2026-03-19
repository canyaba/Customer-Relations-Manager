# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
AdminUser.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

sample_image_path = Rails.root.join("public", "icon.png")

customers = [
  {
    full_name: "Diane Zege",
    phone_number: "204-555-1001",
    email_address: "diane@gmail.com",
    notes: "Prefers email contact."
  },
  {
    full_name: "Brian Jokovic",
    phone_number: "204-555-1002",
    email_address: "brian@gmail.com",
    notes: "Met at the spring trade show."
  },
  {
    full_name: "Patel Singh",
    phone_number: "204-555-1003",
    email_address: "patel@gmail.com",
    notes: "Interested in annual pricing."
  },
  {
    full_name: "Zane Patel",
    phone_number: "204-555-1004",
    email_address: "",
    notes: "Needs follow-up for missing email address."
  },
  {
    full_name: "Carla Nguyen",
    phone_number: "204-555-1005",
    email_address: nil,
    notes: "Imported from a spreadsheet with no email listed."
  },
  {
    full_name: "Milo Brooks",
    phone_number: "204-555-1006",
    email_address: "",
    notes: "Requested a phone-first relationship."
  }
]

customers.each do |attributes|
  customer = Customer.find_or_initialize_by(full_name: attributes[:full_name])
  customer.assign_attributes(attributes)
  customer.save!

  next unless sample_image_path.exist?
  next if customer.image.attached?

  customer.image.attach(
    io: File.open(sample_image_path),
    filename: "#{customer.full_name.parameterize}.png",
    content_type: "image/png"
  )
end
