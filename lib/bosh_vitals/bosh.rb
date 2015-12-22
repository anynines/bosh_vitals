module BoshVitals
  module Bosh
    autoload :Connection, File.expand_path('../bosh/connection', __FILE__)
    autoload :VitalChecker, File.expand_path('../bosh/vital_checker', __FILE__)
  end
end
