class BoshVitals::Models::VmVitals
  attr_accessor :deployment_name,
    :job_name,
    :job_index,
    :ips,
    :cid,
    :agent_id,
    :resurrection,
    :dns,
    :state,
    :resource_pool,
    :cpu_sys,
    :cpu_user,
    :cpu_wait,
    :load_avg01,
    :load_avg05,
    :load_avg15,
    :mem,
    :mem_percent,
    :swap,
    :swap_percent,
    :disk_ephemeral_percent,
    :disk_persistent_percent,
    :disk_system_percent

  def to_s
    str = "VMVitals: "
    self.instance_variables.each do |ivar|
      str += "#{ivar}: #{self.instance_variable_get(ivar)}; "
    end
    str
  end
end
