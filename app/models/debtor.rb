class Debtor < ApplicationRecord
  include XmlParser

  GENDER_TRANSLATION = {'0001' => 'Frau', '0002' => 'Herr', '0003' => 'Firma'}

  # WHAT ABOUT DOUBLE RACING? TWO PEOPLE RUNNING THE SAME METHOD AT ONCE.
  # adress_line misspelled? Should be address?
  # what is fixed_value?
  # maybe change name of amount field to amount_with_iso_currency_code

  # double-check that eveything is correctly named and all fields that are supposed to be here is here.
  # should this be below include. check best practice for orders in models.
  validates :system_id, :customer_number, :gender, :first_name, :last_name,
            #:academic_title, :academic_title_2,
            :iso_code_language, :iso_code_language,
            :iso_code_communication_language, :iso_code_address_country,
            :zip, :city, :street, :house_number, #:second_adress_line,
            :phone_number, :email_address,# :mobile_phone_number
            :sap_invoice_number, :fixed_value, :amount, # (with ISO currency code)
            :date_of_export_to_debt_collection, presence: true # Date of export to debt collection

            # ALSO VALIDATE HOW THE DATA IS. IF IT S IS A INTEGER OR STRING ETC.
            # UNIQUE ID VALUES ETC.
  validates :system_id, uniqueness: true
  validates :gender, inclusion: { in: ['Frau', 'Herr', 'Firma'] } # write spec to if this fails.

  def self.import(file)
    debtor_data = XmlParser.parse(file)
    debtor_data.each { |debtor| debtor[:gender] = GENDER_TRANSLATION[debtor[:gender]] }
    debtors = debtor_data.map { |debtor| self.new(debtor) }
    if debtors.map(&:valid?)  # rename to DebtorsXmlParser
      debtor_data.each do |debtor| # picked customer_number to see if unique record.
        self.where(customer_number: debtor[:customer_number]).first_or_create!(debtor)
      end
    else
      debtors # can call debtor.errors.messages to check what was invalid.
    end
  end
end
