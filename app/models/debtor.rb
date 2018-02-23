class Debtor < ApplicationRecord
  include XmlParser # rename to DebtorsXmlParser

  GENDER_TRANSLATION = {'0001' => 'Frau', '0002' => 'Herr', '0003' => 'Firma'}

  # made specific methods when to call validation for challenge. Just to demo
  before_validation :translate_gender, on: [ :create, :save ]
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

  # consider moving methods to separate use_case.
  def self.import(file)
    debtor_attributes_hashes = XmlParser.parse(file)
    debtors = debtor_attributes_hashes.map { |debtor_attributes| self.new(debtor_attributes) }
    self.validate_and_save_imported_debtors!(debtors) # I'm just using instation for validation, then just sedning hasges again. duplication of effort?
  end

  private

  def translate_gender
    unless GENDER_TRANSLATION.values.map { |value| self.gender == value }.any?
      self.gender = GENDER_TRANSLATION[self.gender]
    end
  end

  def self.validate_and_save_imported_debtors!(debtors)
    if debtors.map(&:valid?)
      self.save_imported_debtors!(debtors)
    else
      debtors # call debtor.errors.messages to check what was invalid.
    end
  end

  def self.save_imported_debtors!(debtors)
    debtors.each do |debtor|
      # picked customer_number as attribute to see if unique record.
      self.where(customer_number: debtor[:customer_number]).
        first_or_create!(debtor.attributes)
    end
  end
end
