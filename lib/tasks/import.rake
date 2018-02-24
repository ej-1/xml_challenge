require './lib/debtor_importer'
namespace :import do

  desc 'import debtors'
  task :debtors, [:file] => :environment do |task, args|
    DebtorImporter.import(args.file)
  end
end
