require 'nokogiri' # remove this later
require 'pry'
require 'xpath'
#File.load('./test-data.xml')[i].content

module XmlParser
	def self.parse(file)
		# REMMMBER TO ACTUALYL USE FILE VARIABLE
		doc = Nokogiri::XML(File.open("./test-data.xml")) # File.open("./test-data.xml") { |f| Nokogiri::XML(f) }
		hashify(doc)
	end

	private

	def self.hashify(doc)
		#hash = Nori.new(:parser => :rexml).parse(File.read('./test-data.xml'))
		#debtors = hash['n0:CommissionedOutstandingCollectionsERPBulkRequest']['CommissionedOutstandingCollectionsERPRequestMessage']



		debtors = doc.xpath('//CommissionedOutstandingCollectionsERPRequestMessage')
		debtors.each_with_index.map do |collection, i|


		              #<NumberDefaultIndicator>true</NumberDefaultIndicator>
		              #<NumberDescription languageCode="en"/>
		              #<NumberUsageDenialIndicator>false</NumberUsageDenialIndicator>

		              #<URIDefaultIndicator>true</URIDefaultIndicator>
		              #<URIDescription languageCode="en"/>
		              #<URIUsageDenialIndicator>false</URIUsageDenialIndicator>
		              # design note: 
		            	# after din
			adress = '//CommissionedOutstandingCollections//DebtorParty//Address'
			physical_adress = '//CommissionedOutstandingCollections//DebtorParty//Address'
			{

				system_id: collection.xpath('//CommissionedOutstandingCollections//ID')[i].content,
				customer_number: collection.xpath('//CommissionedOutstandingCollections//DebtorParty//DebtorID')[i].content,

				gender: collection.xpath("#{adress}//PersonName//FormOfAddressCode")[i].content,
				first_name: collection.xpath("#{adress}//PersonName//GivenName")[i].content,
				last_name: collection.xpath("#{adress}//PersonName//FamilyName")[i].content,
				#academic_title: collection.xpath("#{physical_adress}//AcademicTitleCode")[i].content,
				#academic_title_2: collection.xpath("#{physical_adress}//AcademicTitleCode")[i].content,
				# rename academic_title_2
				# ACADEMIC TITES DOES NOT SEEM TO EXIST IN 
				iso_code_language: collection.xpath("#{physical_adress}//CountryName")[i].content,
				# above: why did i not need to require this    CountryName languageCode="de"
				iso_code_communication_language: collection.xpath("#{adress}//Communication//CorrespondenceLanguageName")[i].attributes['languageCode'].value,
				iso_code_address_country: collection.xpath("#{physical_adress}//CountryCode")[i].content,
				zip: collection.xpath("#{physical_adress}//StreetPostalCode")[i].content,
				city: collection.xpath("#{physical_adress}//CityName")[i].content,
				street: collection.xpath("#{physical_adress}//StreetName")[i].content,
				house_number: collection.xpath("#{physical_adress}//StreetName")[i].content,
				#second_adress_line: collection.xpath("#{physical_adress}//CareOfName")[i].content,
				# CareOfName does not seem to exist in test-data.xml
				phone_number: collection.xpath("#{adress}//Telephone//SubscriberID")[i].content,
				# review above
				#mobile_phone_number: collection.xpath("#{adress}//Communication//MobilePhone")[i].content,
				# MobilePhone does not seem to exist.
				email_address: collection.xpath("#{adress}//Communication//Email//URI")[i].content,
				sap_invoice_number: collection.xpath('CommissionedOutstandingCollections//Item//ID')[i].content,
				fixed_value: collection.xpath('CommissionedOutstandingCollections//GroupingCode')[i].content,
				amount: collection.xpath('CommissionedOutstandingCollections//SubmittedAmount')[i].content,
				date_of_export_to_debt_collection: collection.xpath('CommissionedOutstandingCollections//SubmissionDate')[i].content
			}
		end
	end

end

#a = Nori.new(:parser => :rexml).parse(File.read('./test-data.xml'))
#binding.pry
#XmlParser.parse('')
# what about testing
# is the XML api stable?


