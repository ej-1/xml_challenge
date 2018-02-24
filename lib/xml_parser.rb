class XmlParser

  @@ADDRESS = '//CommissionedOutstandingCollections//DebtorParty//Address'
  @@PHYSICAL_ADDRESS = '//CommissionedOutstandingCollections//DebtorParty//Address'

  def self.import(file)
    debtor_attributes_hashes = self.parse(file)
    clean(debtor_attributes_hashes)
    debtors = debtor_attributes_hashes.map { |debtor_attributes| Debtor.new(debtor_attributes) }
    self.validate_and_save_imported_debtors!(debtors)
  end

  private

  def self.parse(file)
    doc = Nokogiri::XML(File.open(file)) # File.open("./test-data.xml")
    hashify(doc)
  end

  def self.clean(attributes_hashes)
    attributes_hashes.each do |hash|
      hash[:system_id] = self.remove_blankspace(hash[:system_id])
    end
  end

  def self.hashify(doc)
    debtors = doc.xpath('//CommissionedOutstandingCollectionsERPRequestMessage')
    debtors.each_with_index.map do |collection, i|
      {
        system_id: collection.xpath('//CommissionedOutstandingCollections//ID')[i].content,
        customer_number: collection.xpath('//CommissionedOutstandingCollections//DebtorParty//DebtorID')[i].content,
        gender: collection.xpath("#{@@ADDRESS}//PersonName//FormOfAddressCode")[i].content,
        first_name: collection.xpath("#{@@ADDRESS}//PersonName//GivenName")[i].content,
        last_name: collection.xpath("#{@@ADDRESS}//PersonName//FamilyName")[i].content,
        iso_code_language: collection.xpath("#{@@PHYSICAL_ADDRESS}//CountryName")[i].content,
        iso_code_communication_language: collection.xpath("#{@@ADDRESS}//Communication//CorrespondenceLanguageName")[i].attributes['languageCode'].value,
        iso_code_address_country: collection.xpath("#{@@PHYSICAL_ADDRESS  }//CountryCode")[i].content,
        zip: collection.xpath("#{@@PHYSICAL_ADDRESS}//StreetPostalCode")[i].content,
        city: collection.xpath("#{@@PHYSICAL_ADDRESS}//CityName")[i].content,
        street: collection.xpath("#{@@PHYSICAL_ADDRESS}//StreetName")[i].content.split(' ').first,
        house_number: collection.xpath("#{@@PHYSICAL_ADDRESS}//StreetName")[i].content.split(' ').last,
        phone_number: collection.xpath("#{@@ADDRESS}//Telephone//SubscriberID")[i].content,
        mobile_phone_number: collection.xpath("#{@@ADDRESS}//Telephone//SubscriberID")[i].content,
        email_address: collection.xpath("#{@@ADDRESS}//Communication//Email//URI")[i].content,
      }
    end
  end

  def self.remove_blankspace(string)
    string.gsub(/\s+/, "")
  end

  def self.validate_and_save_imported_debtors!(debtors)
    self.save_imported_debtors!(debtors) if debtors.map(&:valid?)
  end

  def self.save_imported_debtors!(debtors)
    debtors.each do |debtor|
      # picked system_id as attribute to see if unique record.
      Debtor.where(system_id: debtor[:customer_number]).
        first_or_create!(debtor.attributes)
    end
  end
end
