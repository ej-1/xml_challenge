require 'nokogiri' # remove this later
require 'pry'
require 'xpath'

#File.load('./test-data.xml')[i].content

class XmlParser

end

# what about testing
# is the XML api stable?


doc = Nokogiri::XML(File.open("./test-data.xml")) # File.open("./test-data.xml") { |f| Nokogiri::XML(f) }

binding.pry
collections = doc.xpath('//CommissionedOutstandingCollectionsERPRequestMessage')

debtors = collections.each_with_index.map do |collection, i|


              #<NumberDefaultIndicator>true</NumberDefaultIndicator>
              #<NumberDescription languageCode="en"/>
              #<NumberUsageDenialIndicator>false</NumberUsageDenialIndicator>

              #<URIDefaultIndicator>true</URIDefaultIndicator>
              #<URIDescription languageCode="en"/>
              #<URIUsageDenialIndicator>false</URIUsageDenialIndicator>

	{
		debtor_id: collection.xpath('//DebtorID')[i].content,

		form_of_adress_code: collection.xpath('//PersonName//FormOfAddressCode')[i].content,
		given_name: 				 collection.xpath('//PersonName//GivenName')[i].content,
		family_name:         collection.xpath('//PersonName//FamilyName')[i].content,

		# what is this? <OrganisationFormattedName/>

		adress_country_code:  collection.xpath('//PhysicalAddress//CountryCode')[i].content,
		street_postal_code:	 	collection.xpath('//PhysicalAddress//StreetPostalCode')[i].content,
		city_name: 					 	collection.xpath('//PhysicalAddress//CityName')[i].content,
		country_code: 				collection.xpath('//PhysicalAddress//CountryCode')[i].content,
		street_name: 					collection.xpath('//PhysicalAddress//StreetName')[i].content,

		corr_lang_code: 			collection.xpath('//Communication//CorrespondenceLanguageCode')[i].content, # Is this needed?
		#corr_lang_name: 			collection.xpath('//Communication//CorrespondenceLanguageName languageCode')[i].content,

		subscriber_id: 				collection.xpath('//Telephone//Number//SubscriberID')[i].content,
		phone_country_code: 	collection.xpath('//Telephone//Number//CountryCode')[i].content,
		country_dialling_code:collection.xpath('//Telephone//Number//CountryDiallingCode')[i].content,

		email: collection.xpath('//Email//URI')[i].content
	}

end
