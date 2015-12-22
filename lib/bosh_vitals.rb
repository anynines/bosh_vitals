require "bosh_vitals/version"
require 'logger'

module BoshVitals
  autoload :Models, File.expand_path('../bosh_vitals/models', __FILE__)
  autoload :Bosh, File.expand_path('../bosh_vitals/bosh', __FILE__)

  @@logger = ::Logger.new(STDOUT)

  def self.logger
    @@logger
  end
end
