module BoshVitals
  module Checkers
    autoload :VmVitalsChecker, File.expand_path('../checkers/vm_vitals_checker', __FILE__)
    autoload :VmVitalsCheckerConfiguration, File.expand_path('../checkers/vm_vitals_checker_configuration', __FILE__)
  end
end
