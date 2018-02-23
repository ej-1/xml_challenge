module XmlParser
	def self.parse(file)
		doc = Nokogiri::XML(File.open(file)) # File.open("./test-data.xml")
		hashify(doc)
	end

	private

	def self.hashify(doc)
		debtors = doc.xpath('//CommissionedOutstandingCollectionsERPRequestMessage')
		address = '//CommissionedOutstandingCollections//DebtorParty//Address'
		physical_address = '//CommissionedOutstandingCollections//DebtorParty//Address'
		item = '//CommissionedOutstandingCollections//Item'
		debtors.each_with_index.map do |collection, i|
			invoices = collection.xpath('CommissionedOutstandingCollections//Item').each_with_index.map do |invoice, i|
				{
					sap_invoice_number: collection.xpath("#{item}//ID")[i].content,
					fixed_value: collection.xpath("#{item}//GroupingCode")[i].content,
					amount: collection.xpath("#{item}//SubmittedAmount")[i].content,
					date_of_export_to_debt_collection: collection.xpath("#{item}//SubmissionDate")[i].content
				}
			end
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
				email_address: collection.xpath("#{address}//Communication//Email//URI")[i].content,
				invoices: invoices,
			}
		end
	end
end
