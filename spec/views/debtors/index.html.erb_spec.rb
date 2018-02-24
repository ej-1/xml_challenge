require 'rails_helper'

RSpec.describe "debtors/index", type: :view do

  let(:valid_attributes) {
    {
      :system_id => "INK0034628681287",
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
      :email_address => "hans.fakeson@fake.de"
    }
  }

  before(:each) do
    valid_attributes_two = valid_attributes.dup
    valid_attributes_two[:system_id] = '123455'
    assign(:debtors, [
      Debtor.create!(valid_attributes),
      Debtor.create!(valid_attributes_two)
    ])
  end

  it "renders a list of debtors" do
    # can add more specs in the future.
    expect(render).to include('<td><a href="/debtors/1">Show</a></td>')
    expect(render).to include('<td>INK0034628681287</td>')
    expect(render).to include('<td>4628681287</td>')
    expect(render).to include('<td><a href="/debtors/2">Show</a></td>')
    expect(render).to include('<td>123455</td>')
    expect(render).to include('<td>4628681287</td>')
  end
end
