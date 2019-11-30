namespace :notifications do
  desc "Check notes updated"
  task notes: :environment do
    CheckPucPrNotesWorker.new.perform()
  end
end