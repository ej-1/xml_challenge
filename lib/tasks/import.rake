require './lib/xml_parser'
namespace :import do

  desc 'import debtors' # rake import:debtors['./test-data.xml']
  task :debtors, [:file] => :environment do |task, args|
    XmlParser.import(args.file)
  end
end
