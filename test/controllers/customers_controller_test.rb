require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "gets the index page" do
    get root_url

    assert_response :success
    assert_select "h1", "All Customers"
    assert_select "a[href='#{alphabetized_customers_path}']"
    assert_select "a[href='#{missing_email_customers_path}']"
  end

  test "gets the alphabetized page in name order" do
    get alphabetized_customers_url

    assert_response :success
    assert_operator response.body.index("Alice Zephyr"), :<, response.body.index("Brian Carter")
    assert_operator response.body.index("Brian Carter"), :<, response.body.index("Carla Nguyen")
  end

  test "gets the missing email page with only missing email customers" do
    get missing_email_customers_url

    assert_response :success
    assert_includes response.body, "Carla Nguyen"
    assert_includes response.body, "Milo Brooks"
    assert_not_includes response.body, "Alice Zephyr"
  end
end
