require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "requires a full name" do
    customer = Customer.new(email_address: "valid@example.com")

    assert_not customer.valid?
    assert_includes customer.errors[:full_name], "can't be blank"
  end

  test "allows a blank email address" do
    customer = Customer.new(full_name: "No Email Customer", email_address: "")

    assert customer.valid?
  end

  test "rejects an invalid email address" do
    customer = Customer.new(full_name: "Bad Email", email_address: "not-an-email")

    assert_not customer.valid?
    assert_includes customer.errors[:email_address], "is invalid"
  end

  test "missing_email returns blank and nil email customers" do
    assert_includes Customer.missing_email, customers(:carla_nil_email)
    assert_includes Customer.missing_email, customers(:milo_blank_email)
    assert_not_includes Customer.missing_email, customers(:alice_zephyr)
  end

  test "alphabetized orders by full name ascending" do
    expected_names = Customer.order(:full_name).pluck(:full_name)

    assert_equal expected_names, Customer.alphabetized.pluck(:full_name)
  end
end
