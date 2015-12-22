class BoshVitals::Checkers::VmVitalsChecker
  attr_accessor :configuration

  DEFAULT_PERSISTENT_DISK_WARNING_PERCENTAGE = 70 # TODO: change
  DEFAULT_SYSTEM_DISK_WARNING_PERCENTAGE = 70 # TODO: change
  DEFAULT_EPHEMERAL_DISK_WARNING_PERCENTAGE = 70 # TODO: change

  DEFAULT_MEM_WARNING_PERCENTAGE = 90 # TODO: change

  def check(vm_vitals)
    check_state vm_vitals
    check_persistent_disk vm_vitals
    check_system_disk vm_vitals
    check_ephemeral_disk vm_vitals
    check_mem vm_vitals
  end

  def check_all(vitals_array)
    vitals_array.each do |vit|
      check vit
    end
  end

  protected

  # Checks
  def check_state(vm_vitals)
    alert_warning "[STATE] A job is not in running state: #{vm_vitals}" if vm_vitals.state != "running"
  end

  def check_persistent_disk(vm_vitals, threshold = DEFAULT_PERSISTENT_DISK_WARNING_PERCENTAGE)
    alert_warning "[DISK] A job's PERSISTENT disk is running out of space - #{vm_vitals.disk_persistent_percent} % are in use : #{vm_vitals}" if vm_vitals.disk_persistent_percent.to_i > threshold
  end

  def check_system_disk(vm_vitals, threshold = DEFAULT_SYSTEM_DISK_WARNING_PERCENTAGE)
    alert_warning "[DISK] A job's SYSTEM disk is running out of space - #{vm_vitals.disk_system_percent} % are in use : #{vm_vitals}" if vm_vitals.disk_system_percent.to_i > threshold
  end

  def check_ephemeral_disk(vm_vitals, threshold = DEFAULT_EPHEMERAL_DISK_WARNING_PERCENTAGE)
    alert_warning "[DISK] A job's EPHEMERAL disk is running out of space - #{vm_vitals.disk_ephemeral_percent} % are in use : #{vm_vitals}" if vm_vitals.disk_ephemeral_percent.to_i > threshold
  end

  def check_mem(vm_vitals, threshold = DEFAULT_MEM_WARNING_PERCENTAGE)
    alert_warning "[MEM] A job's MEMORY is growing too large - #{vm_vitals.mem_percent} % are in use : #{vm_vitals}" if vm_vitals.mem_percent.to_i > threshold
  end

  def alert_error(message)
    BoshVitals.logger.error message
  end

  def alert_warning(message)
    BoshVitals.logger.warn message
  end
end
