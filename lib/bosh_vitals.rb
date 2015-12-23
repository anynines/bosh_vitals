require "bosh_vitals/version"
require 'logger'

module BoshVitals
  autoload :Models, File.expand_path('../bosh_vitals/models', __FILE__)
  autoload :Bosh, File.expand_path('../bosh_vitals/bosh', __FILE__)
  autoload :Checkers, File.expand_path('../bosh_vitals/checkers', __FILE__)

  @@logger = nil

  def self.logger
    if @@logger.nil?
      if ENV["LOGGER"].nil? || ENV["LOGGER"] == 'STDOUT'
        @@logger = ::Logger.new(STDOUT)
      else
        @@logger = ::Logger.new(ENV["LOGGER"])
      end
    end
    @@logger
  end
end
