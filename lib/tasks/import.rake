require './lib/xml_parser'
#namespace :import do

	desc 'import debtors' # rake debtors['./test-data.xml']
  task :debtors, [:file] => :environment do |task, args|
  	binding.pry
  	XmlParser.import(args.file)
  end
#end
