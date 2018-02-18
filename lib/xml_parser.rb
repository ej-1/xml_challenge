require 'nokogiri' # remove this later
require 'pry'

binding.pry
File.load('./test-data.xml')

class XmlParser

end

# what about testing
# is the XML api stable?


doc = File.open("./test-data.xml") { |f| Nokogiri::XML(f) }

collection = doc.xpath('//CommissionedOutstandingCollectionsERPRequestMessage')
collections.each do |collection|
	debtor_id = collection.xpath('//DebtorID')

	person_name 				= collection.xpath('//PersonName')
	form_of_adress_code = person_name.xpath('//FormOfAddressCode')
	given_name 					= person_name.xpath('//GivenName')
	family_name 				=	person_name.xpath('//FamilyName')

	# what is this? <OrganisationFormattedName/>

	physical_adress 		= collection.xpath('//PhysicalAddress')
	adress_country_code 				= physical_adress.xpath('//CountryCode')
	street_postal_code	= physical_adress.xpath('//StreetPostalCode')
	city_name 					= physical_adress.xpath('//CityName')
	country_code 				= physical_adress.xpath('//CountryCode')
	street_name 				= physical_adress.xpath('//StreetName')

	communication 			= collection.xpath('//Communication')
	corr_lang_code 				= communication.xpath('//CorrespondenceLanguageCode') # Is this needed?
	corr_lang_name 				= communication.xpath('//CorrespondenceLanguageName languageCode')

	telephone 			= communication.xpath('//Telephone')
	telephone_number 			= telephone.xpath('//Number')
	subscriber_id 			= telephone_number.xpath('//SubscriberID')
	phone_country_code 			= telephone_number.xpath('//CountryCode')
	country_dialling_code 			= telephone_number.xpath('//CountryDiallingCode')

              #<NumberDefaultIndicator>true</NumberDefaultIndicator>
              #<NumberDescription languageCode="en"/>
              #<NumberUsageDenialIndicator>false</NumberUsageDenialIndicator>
	email 			= communication.xpath('//Email')
              #<URIDefaultIndicator>true</URIDefaultIndicator>
              #<URIDescription languageCode="en"/>
              #<URIUsageDenialIndicator>false</URIUsageDenialIndicator>
end

