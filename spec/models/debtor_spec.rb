require 'rails_helper'

RSpec.describe Debtor, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"

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
			:email_address => "hans.fakeson@fake.de",
			:sap_invoice_number => "010000001282001",
			:fixed_value => "01",
			:amount => "269.88",
			:date_of_export_to_debt_collection => "2017-12-19"
    }
  }

  let(:invalid_attributes) {
    {
			:system_id => "INK003    4628681287",
			:customer_number => "4628681287",
			:gender => "0009",
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
			:email_address => "hans.fakeson@fake.de",
			:sap_invoice_number => "010000001282001",
			:fixed_value => "01",
			:amount => "269.88",
			:date_of_export_to_debt_collection => "2017-12-19"
    }
  }

  it "has none to begin with" do
    expect(Debtor.count.should).to eq 0
  end

  it "has one after adding one" do
    Debtor.create! valid_attributes
    expect(Debtor.count.should).to eq 1
  end

  it "has none after one was created in a previous example" do
    expect(Debtor.count.should).to eq 0
  end

	it "fails to translate gender codes" do
	debtor = Debtor.new invalid_attributes
	expect(debtor).to_not be_valid
	expect(debtor.errors.messages[:gender]).
		to eq ["can't be blank", "is not included in the list"]
	expect(Debtor.count).to eq 0
end

  describe "#import" do
    it "saves new debtors" do
			Debtor.import 'test-data.xml'
      expect(Debtor.count).to eq 3
    end

    it "translates gender codes" do
			Debtor.import 'test-data.xml'
      expect(Debtor.first.gender).to eq 'Frau'
      expect(Debtor.second.gender).to eq 'Frau'
      expect(Debtor.last.gender).to eq 'Herr'
    end
  end

end
