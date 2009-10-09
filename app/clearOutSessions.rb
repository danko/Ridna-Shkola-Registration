CGI::Session::ActiveRecordStore::Session.delete_all(["updated_at < ?", 12.hours.ago])
