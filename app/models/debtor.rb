class Debtor < ApplicationRecord
  include XmlParser # rename to DebtorsXmlParser

  GENDER_TRANSLATION = {'0001' => 'Frau', '0002' => 'Herr', '0003' => 'Firma'}

  # made specific methods when to call validation for challenge. Just to demo in challenge.
  before_validation :translate_gender, on: [ :create, :save ]

  validates :system_id, :customer_number, :gender, :first_name, :last_name,
            :iso_code_language, :iso_code_language,
            :iso_code_communication_language, :iso_code_address_country,
            :zip, :city, :street, :house_number,
            :phone_number, :mobile_phone_number, :email_address,
            :sap_invoice_number, :fixed_value, :amount, # (with ISO currency code)
            :date_of_export_to_debt_collection, presence: true

  # add more validations in the future for data formats.
  validates :system_id, uniqueness: true
  validates :gender, inclusion: { in: ['Frau', 'Herr', 'Firma'] } # write spec to if this fails.

  # consider moving methods to separate use_case.
  # WHAT ABOUT DOUBLE RACING? TWO PEOPLE RUNNING THE SAME METHOD AT ONCE.
  def self.import(file)
    debtor_attributes_hashes = XmlParser.parse(file)
    debtors = debtor_attributes_hashes.map { |debtor_attributes| self.new(debtor_attributes) }
    self.validate_and_save_imported_debtors!(debtors)
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
      # call debtor.errors.messages to check what was invalid.
      debtors
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
