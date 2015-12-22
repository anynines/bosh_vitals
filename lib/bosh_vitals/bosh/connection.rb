require 'httparty'
require 'json'

class BoshVitals::Bosh::Connection

  attr_accessor :username, :password, :port, :host

  ENV_BOSH_HOST = 'BOSH_HOST'
  ENV_BOSH_PORT = 'BOSH_PORT'
  ENV_BOSH_PASSWORD = 'BOSH_PASSWORD'
  ENV_BOSH_USERNAME = 'BOSH_USERNAME'

  def initialize(opts = nil)
    if opts.nil?
      read_env_from_environment
    else
      verify_options opts
      set_options
    end
  end

  def execute_query(endpoint, options = {})
    options.merge!({basic_auth: auth, verify: false})
    print options
    result = HTTParty.get("#{base_uri}#{endpoint}", options)
    return JSON.parse(result.body)
  end

  def login
    BoshVitals.logger.info "Logging in to ##{self.base_uri} with user #{self.username}"
    ret = system("bosh target #{self.base_uri}")
    raise "Setting target to #{self.base_uri} failed!" unless ret
    ret = system("bosh login #{self.username} #{self.password}")
    raise "Login failed!" unless ret
  end

  def execute_command(command, option_string = "")
    resp = `bosh #{command} #{option_string}`
    raise "Return code was != 0" unless $? == 0
    resp
  end

  protected

  # Loads the needed environment variables from the shell environment
  #
  # Required vals: BOSH_HOST, BOSH_PORT, BOSH_PASSWORD, BOSH_USERNAME
  def read_env_from_environment
    opts_hash = {
      host: ENV[ENV_BOSH_HOST],
      port: ENV[ENV_BOSH_PORT],
      username: ENV[ENV_BOSH_USERNAME],
      password: ENV[ENV_BOSH_PASSWORD]
    }

    verify_options opts_hash
    set_options opts_hash
  end

  def verify_options(opts)
    raise "No options given!" if opts.nil?
    raise "Options are no hash!" unless opts.is_a?(Hash)

    raise "No host specified!" if opts[:host].nil?
    raise "No port specified!" if opts[:port].nil?
    raise "No username specified!" if opts[:username].nil?
    raise "No password specified!" if opts[:password].nil?

    raise "No valid port specified!" if opts[:port].to_i == 0
  end

  def set_options(opts)
    self.host = opts[:host]
    self.port = opts[:port].to_i
    self.username = opts[:username]
    self.password = opts[:password]
  end

  def auth
    {
      :username => self.username,
      :password => self.password
    }
  end

  def base_uri
    "https://#{self.host}:#{self.port.to_s}/"
  end
end
