class XmlParser

	def self.import(file)
    debtor_attributes_hashes = self.parse(file)
    debtors = debtor_attributes_hashes.map { |debtor_attributes| Debtor.new(debtor_attributes) }
    self.validate_and_save_imported_debtors!(debtors)
	end

	private

	def self.parse(file)
		doc = Nokogiri::XML(File.open(file)) # File.open("./test-data.xml")
		hashify(doc)
	end

	def self.hashify(doc)
		debtors = doc.xpath('//CommissionedOutstandingCollectionsERPRequestMessage')
		address = '//CommissionedOutstandingCollections//DebtorParty//Address'
		physical_address = '//CommissionedOutstandingCollections//DebtorParty//Address'
		debtors.each_with_index.map do |collection, i|
			{
				system_id: collection.xpath('//CommissionedOutstandingCollections//ID')[i].content,
				customer_number: collection.xpath('//CommissionedOutstandingCollections//DebtorParty//DebtorID')[i].content,
				gender: collection.xpath("#{address}//PersonName//FormOfAddressCode")[i].content,
				first_name: collection.xpath("#{address}//PersonName//GivenName")[i].content,
				last_name: collection.xpath("#{address}//PersonName//FamilyName")[i].content,
				iso_code_language: collection.xpath("#{physical_address}//CountryName")[i].content,
				iso_code_communication_language: collection.xpath("#{address}//Communication//CorrespondenceLanguageName")[i].attributes['languageCode'].value,
				iso_code_address_country: collection.xpath("#{physical_address}//CountryCode")[i].content,
				zip: collection.xpath("#{physical_address}//StreetPostalCode")[i].content,
				city: collection.xpath("#{physical_address}//CityName")[i].content,
				street: collection.xpath("#{physical_address}//StreetName")[i].content.split(' ').first,
				house_number: collection.xpath("#{physical_address}//StreetName")[i].content.split(' ').last,
				phone_number: collection.xpath("#{address}//Telephone//SubscriberID")[i].content,
				mobile_phone_number: collection.xpath("#{address}//Telephone//SubscriberID")[i].content,
				email_address: collection.xpath("#{address}//Communication//Email//URI")[i].content,
				sap_invoice_number: collection.xpath('CommissionedOutstandingCollections//Item//ID')[i].content,
				fixed_value: collection.xpath('CommissionedOutstandingCollections//GroupingCode')[i].content,
				amount: collection.xpath('CommissionedOutstandingCollections//SubmittedAmount')[i].content,
				date_of_export_to_debt_collection: collection.xpath('CommissionedOutstandingCollections//SubmissionDate')[i].content
			}
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
      Debtor.where(customer_number: debtor[:customer_number]).
        first_or_create!(debtor.attributes)
    end
  end
end
