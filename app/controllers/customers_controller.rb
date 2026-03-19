class CustomersController < ApplicationController
  def index
    @customers = Customer.with_attached_image
  end

  def alphabetized
    @customers = Customer.with_attached_image.alphabetized
  end

  def missing_email
    @customers = Customer.with_attached_image.missing_email
  end
end
