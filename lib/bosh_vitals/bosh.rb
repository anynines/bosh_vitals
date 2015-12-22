module BoshVitals
  module Bosh
    autoload :Connection, File.expand_path('../bosh/connection', __FILE__)
    autoload :VitalFetcher, File.expand_path('../bosh/vital_fetcher', __FILE__)
  end
end
