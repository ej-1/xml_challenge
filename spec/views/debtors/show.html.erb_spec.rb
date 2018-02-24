require 'rails_helper'

RSpec.describe "debtors/show", type: :view do

  let(:valid_attributes) {
    {
      :system_id => "INK003    4628681287",
      :customer_number => "4628681287",
      :gender => "0001",
      :first_name => "hans",
      :last_name => "fakeson",
      :iso_code_language => "AT",
      :iso_code_communication_language => "de",
      :iso_code_address_country => "AT",
      :zip => "1111",
      :city => "Wien",
      :street => "test 123",
      :house_number => "test 123",
      :phone_number => "+4364412312312",
      :mobile_phone_number => "+4364412312312",
      :email_address => "hans.fakeson@fake.de",
    }
  }

  before(:each) do
    @debtor = assign(:debtor, Debtor.create!(valid_attributes))
  end

  it "renders attributes in <p>" do
    render
  end
end
