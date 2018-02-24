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

  it "renders attributes" do
    expect(render).to include('<li><strong>system_id</strong> INK003    4628681287</li>')
    expect(render).to include('<li><strong>gender</strong> Frau</li>')
    expect(render).to include('<li><strong>first_name</strong> hans</li>')
    expect(render).to include('<li><strong>last_name</strong> fakeson</li>')
    expect(render).to include('<li><strong>iso_code_language</strong> AT</li>')
    expect(render).to include('<li><strong>iso_code_communication_language</strong> de</li>')
    expect(render).to include('<li><strong>iso_code_address_country</strong> AT</li>')
    expect(render).to include('<li><strong>zip</strong> 1111</li>')
    expect(render).to include('<li><strong>city</strong> Wien</li>')
    expect(render).to include('<li><strong>street</strong> test 123</li>')
    expect(render).to include('<li><strong>house_number</strong> test 123</li>')
    expect(render).to include('<li><strong>phone_number</strong> +4364412312312</li>')
    expect(render).to include('<li><strong>mobile_phone_number</strong> +4364412312312</li>')
    expect(render).to include('<li><strong>email_address</strong> hans.fakeson@fake.de</li>')
    expect(render).to include('<li><strong>sap_invoice_number</strong> </li>')
    expect(render).to include('<li><strong>fixed_value</strong> </li>')
    expect(render).to include('<li><strong>email_address</strong> hans.fakeson@fake.de</li>')
    expect(render).to include('<li><strong>sap_invoice_number</strong> </li>')
    expect(render).to include('<li><strong>fixed_value</strong> </li>')
    expect(render).to include('<li><strong>amount</strong> </li>')
    expect(render).to include('<li><strong>date_of_export_to_debt_collection</strong> </li>')
  end
end
