class BoshVitals::Checkers::VmVitalsChecker
  attr_reader :configuration, # => BoshVitals::Checkers::Configuration
    :warnings,
    :alerts

  def initialize(config = BoshVitals::Checkers::VmVitalsCheckerConfiguration.new)
    raise "The given config is nil!" if config.nil?
    @configuration = config
    @warnings = Array.new
    @alerts = Array.new
  end

  def check(vm_vitals)
    ret_state = check_state(vm_vitals)
    ret_pers = check_persistent_disk(vm_vitals,
      self.configuration.warning_persistent_disk_percentage,
      self.configuration.alert_persistent_disk_percentage)
    ret_sys = check_system_disk(vm_vitals,
      self.configuration.warning_system_disk_percentage,
      self.configuration.alert_system_disk_percentage)
    ret_eph = check_ephemeral_disk(vm_vitals,
      self.configuration.warning_ephemeral_disk_percentage,
      self.configuration.alert_ephemeral_disk_percentage)
    ret_mem = check_mem(vm_vitals,
      self.configuration.warning_mem_percentage,
      self.configuration.alert_mem_percentage)
    ret_swap = check_swap(vm_vitals,
      self.configuration.warning_swap_percentage,
      self.configuration.alert_swap_percentage)
    ret_state && ret_pers && ret_sys && ret_eph && ret_mem && ret_swap
  end

  def check_all(vitals_array)
    ret = true
    vitals_array.each do |vit|
      ret = check(vit) if ret == true
    end
    ret
  end

  def alerts_present?
    self.alerts.count > 0
  end

  def warnings_present?
    self.warnings.count > 0
  end

  def clear
    @warnings = Array.new
    @alerts = Array.new
  end

  def generate_message_from_result
    return 'Status All Systems up and running' if !alerts_present? && !warnings_present?
    st = "Status: Problems found"
    st = "#{st} - [Warnings] - #{self.warnings.inspect} ;" if warnings_present?
    st = "#{st} - [Alerts] - #{self.alerts.inspect} ;" if alerts_present?
    st
  end

  protected

  # Checks
  def check_state(vm_vitals)
    ret = true
    msg = "[STATE] A job is not in running state: #{vm_vitals}"
    if vm_vitals.state != "running"
      alert_error msg
      @alerts << msg
      ret = false
    end
    return ret
  end

  def check_persistent_disk(vm_vitals, warning_threshold, alert_threshold)
    ret = true
    msg = "[DISK] A job's PERSISTENT disk is running out of space - #{vm_vitals.disk_persistent_percent} % are in use : #{vm_vitals}"
    if vm_vitals.disk_persistent_percent.to_i > alert_threshold.to_i
      alert_error msg
      @alerts << msg
      ret = false
    elsif vm_vitals.disk_persistent_percent.to_i > warning_threshold.to_i
      alert_warning msg
      warnings << msg
      ret = false
    end
    return ret
  end

  def check_system_disk(vm_vitals, warning_threshold, alert_threshold)
    ret = true
    msg = "[DISK] A job's SYSTEM disk is running out of space - #{vm_vitals.disk_system_percent} % are in use : #{vm_vitals}"
    if vm_vitals.disk_system_percent.to_i > alert_threshold.to_i
      alert_error msg
      @alerts << msg
      ret = false
    elsif vm_vitals.disk_system_percent.to_i > warning_threshold.to_i
      alert_warning msg
      warnings << msg
      ret = false
    end
    return ret
  end

  def check_ephemeral_disk(vm_vitals, warning_threshold, alert_threshold)
    ret = true
    msg = "[DISK] A job's EPHEMERAL disk is running out of space - #{vm_vitals.disk_ephemeral_percent} % are in use : #{vm_vitals}"
    if vm_vitals.disk_ephemeral_percent.to_i > alert_threshold.to_i
      alert_error msg
      @alerts << msg
      ret = false
    elsif vm_vitals.disk_ephemeral_percent.to_i > warning_threshold.to_i
      alert_warning msg
      warnings << msg
      ret = false
    end
    return ret
  end

  def check_mem(vm_vitals, warning_threshold, alert_threshold)
    ret = true
    msg = "[MEM] A job's MEMORY is growing too large - #{vm_vitals.mem_percent} % are in use : #{vm_vitals}"
    if vm_vitals.mem_percent.to_i > alert_threshold.to_i
      alert_error msg
      @alerts << msg
      ret = false
    elsif vm_vitals.mem_percent.to_i > warning_threshold.to_i
      alert_warning msg
      warnings << msg
      ret = false
    end
    return ret
  end

  def check_swap(vm_vitals, warning_threshold, alert_threshold)
    ret = true
    msg = "[SWAP] A job's SWAP is growing too large - #{vm_vitals.swap_percent} % are in use : #{vm_vitals}"
    if vm_vitals.swap_percent.to_i > alert_threshold.to_i
      alert_error msg
      @alerts << msg
      ret = false
    elsif vm_vitals.swap_percent.to_i > warning_threshold.to_i
      alert_warning msg
      warnings << msg
      ret = false
    end
    return ret
  end

  def alert_error(message)
    BoshVitals.logger.error message
  end

  def alert_warning(message)
    BoshVitals.logger.warn message
  end
end
