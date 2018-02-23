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
		debtors.each_with_index.map do |collection, i|
			{
				system_id: collection.xpath('//CommissionedOutstandingCollections//ID')[i].content,
				customer_number: collection.xpath('//CommissionedOutstandingCollections//DebtorParty//DebtorID')[i].content,
				gender: collection.xpath("#{address}//PersonName//FormOfAddressCode")[i].content,
				first_name: collection.xpath("#{address}//PersonName//GivenName")[i].content,
				last_name: collection.xpath("#{address}//PersonName//FamilyName")[i].content,
				#academic_title: collection.xpath("#{physical_address}//AcademicTitleCode")[i].content,
				#academic_title_2: collection.xpath("#{physical_address}//AcademicTitleCode")[i].content,
				# rename academic_title_2
				# ACADEMIC TITES DOES NOT SEEM TO EXIST IN 
				iso_code_language: collection.xpath("#{physical_address}//CountryName")[i].content,
				# above: why did i not need to require this    CountryName languageCode="de"
				iso_code_communication_language: collection.xpath("#{address}//Communication//CorrespondenceLanguageName")[i].attributes['languageCode'].value,
				iso_code_address_country: collection.xpath("#{physical_address}//CountryCode")[i].content,
				zip: collection.xpath("#{physical_address}//StreetPostalCode")[i].content,
				city: collection.xpath("#{physical_address}//CityName")[i].content,
				street: collection.xpath("#{physical_address}//StreetName")[i].content,
				house_number: collection.xpath("#{physical_address}//StreetName")[i].content,
				#second_address_line: collection.xpath("#{physical_address}//CareOfName")[i].content,
				# CareOfName does not seem to exist in test-data.xml
				phone_number: collection.xpath("#{address}//Telephone//SubscriberID")[i].content,
				# review above
				#mobile_phone_number: collection.xpath("#{address}//Communication//MobilePhone")[i].content,
				# MobilePhone does not seem to exist.
				email_address: collection.xpath("#{address}//Communication//Email//URI")[i].content,
				sap_invoice_number: collection.xpath('CommissionedOutstandingCollections//Item//ID')[i].content,
				fixed_value: collection.xpath('CommissionedOutstandingCollections//GroupingCode')[i].content,
				amount: collection.xpath('CommissionedOutstandingCollections//SubmittedAmount')[i].content,
				date_of_export_to_debt_collection: collection.xpath('CommissionedOutstandingCollections//SubmissionDate')[i].content
			}
		end
	end
end
