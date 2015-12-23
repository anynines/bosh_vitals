class BoshVitals::Checkers::VmVitalsCheckerConfiguration
  attr_accessor :warning_persistent_disk_percentage,
    :warning_system_disk_percentage,
    :warning_ephemeral_disk_percentage,
    :warning_mem_percentage,
    :warning_swap_percentage,
    :alert_persistent_disk_percentage,
    :alert_system_disk_percentage,
    :alert_ephemeral_disk_percentage,
    :alert_mem_percentage,
    :alert_swap_percentage

  # Warning settings
  DEFAULT_PERSISTENT_DISK_WARNING_PERCENTAGE = 70 # TODO: change
  DEFAULT_SYSTEM_DISK_WARNING_PERCENTAGE = 70 # TODO: change
  DEFAULT_EPHEMERAL_DISK_WARNING_PERCENTAGE = 70 # TODO: change

  DEFAULT_MEM_WARNING_PERCENTAGE = 90 # TODO: change
  DEFAULT_SWAP_WARNING_PERCENTAGE = 90 # TODO: change

  # Alert settings
  DEFAULT_PERSISTENT_DISK_ALERT_PERCENTAGE = 90 # TODO: change
  DEFAULT_SYSTEM_DISK_ALERT_PERCENTAGE = 90 # TODO: change
  DEFAULT_EPHEMERAL_DISK_ALERT_PERCENTAGE = 90 # TODO: change

  DEFAULT_MEM_ALERT_PERCENTAGE = 95 # TODO: change
  DEFAULT_SWAP_ALERT_PERCENTAGE = 95 # TODO: change

  def initialize(load_cfg_from_env = true)
    self.warning_persistent_disk_percentage = DEFAULT_PERSISTENT_DISK_WARNING_PERCENTAGE
    self.warning_system_disk_percentage = DEFAULT_SYSTEM_DISK_WARNING_PERCENTAGE
    self.warning_ephemeral_disk_percentage = DEFAULT_EPHEMERAL_DISK_WARNING_PERCENTAGE
    self.warning_mem_percentage = DEFAULT_MEM_WARNING_PERCENTAGE
    self.warning_swap_percentage = DEFAULT_SWAP_WARNING_PERCENTAGE

    self.alert_persistent_disk_percentage = DEFAULT_PERSISTENT_DISK_ALERT_PERCENTAGE
    self.alert_system_disk_percentage = DEFAULT_SYSTEM_DISK_ALERT_PERCENTAGE
    self.alert_ephemeral_disk_percentage = DEFAULT_EPHEMERAL_DISK_ALERT_PERCENTAGE
    self.alert_mem_percentage = DEFAULT_MEM_ALERT_PERCENTAGE
    self.alert_swap_percentage = DEFAULT_SWAP_ALERT_PERCENTAGE

    load_config_from_environment if load_cfg_from_env
  end

  def load_config_from_environment
    self.warning_persistent_disk_percentage = ENV["DEFAULT_PERSISTENT_DISK_WARNING_PERCENTAGE"] unless ENV["DEFAULT_PERSISTENT_DISK_WARNING_PERCENTAGE"].nil?
    self.warning_system_disk_percentage = ENV["DEFAULT_SYSTEM_DISK_WARNING_PERCENTAGE"] unless ENV["DEFAULT_SYSTEM_DISK_WARNING_PERCENTAGE"].nil?
    self.warning_ephemeral_disk_percentage = ENV["DEFAULT_EPHEMERAL_DISK_WARNING_PERCENTAGE"] unless ENV["DEFAULT_EPHEMERAL_DISK_WARNING_PERCENTAGE"].nil?
    self.warning_mem_percentage = ENV["DEFAULT_MEM_WARNING_PERCENTAGE"] unless ENV["DEFAULT_MEM_WARNING_PERCENTAGE"].nil?
    self.warning_swap_percentage = ENV["DEFAULT_SWAP_WARNING_PERCENTAGE"] unless ENV["DEFAULT_SWAP_WARNING_PERCENTAGE"].nil?

    self.alert_persistent_disk_percentage = ENV["DEFAULT_PERSISTENT_DISK_ALERT_PERCENTAGE"] unless ENV["DEFAULT_PERSISTENT_DISK_ALERT_PERCENTAGE"].nil?
    self.alert_system_disk_percentage = ENV["DEFAULT_SYSTEM_DISK_ALERT_PERCENTAGE"] unless ENV["DEFAULT_SYSTEM_DISK_ALERT_PERCENTAGE"].nil?
    self.alert_ephemeral_disk_percentage = ENV["DEFAULT_EPHEMERAL_DISK_ALERT_PERCENTAGE"] unless ENV["DEFAULT_EPHEMERAL_DISK_ALERT_PERCENTAGE"].nil?
    self.alert_mem_percentage = ENV["DEFAULT_MEM_ALERT_PERCENTAGE"] unless ENV["DEFAULT_MEM_ALERT_PERCENTAGE"].nil?
    self.alert_swap_percentage = ENV["DEFAULT_SWAP_ALERT_PERCENTAGE"] unless ENV["DEFAULT_SWAP_ALERT_PERCENTAGE"].nil?
  end
end
