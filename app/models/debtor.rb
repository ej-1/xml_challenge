class Debtor < ApplicationRecord

  GENDER_TRANSLATION = {'0001' => 'Frau', '0002' => 'Herr', '0003' => 'Firma'}

  # made specific methods when to call validation for challenge. Just to demo in challenge.
  before_validation :translate_gender, on: [ :create, :save ]

  validates :system_id, :customer_number, :gender, :first_name, :last_name,
            :iso_code_language, :iso_code_language,
            :iso_code_communication_language, :iso_code_address_country,
            :zip, :city, :street, :house_number,
            :phone_number, :mobile_phone_number, :email_address, presence: true

  # add more validations in the future for data formats.
  validates :system_id, uniqueness: true
  validates :gender, inclusion: { in: ['Frau', 'Herr', 'Firma'] }

  private

  def translate_gender
    unless GENDER_TRANSLATION.values.map { |value| self.gender == value }.any?
      self.gender = GENDER_TRANSLATION[self.gender]
    end
  end
end
