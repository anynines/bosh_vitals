require 'date'

class BoshVitals::Bosh::VitalFetcher
  attr_accessor :connection

  def initialize(connection)
    self.connection = connection
  end

  def deployment(deployment_name)
    BoshVitals.logger.info "Getting details for deployment #{deployment_name} ..."
    result = self.connection.execute_command("vms", "#{deployment_name} --vitals --details --dns")
    lines = result.split("\n")
    return [] if lines.count < 8

    # Header
    header_a = lines[7]
    header_b = lines[8]

    # Start of the vm section
    vm_lines = lines[10..lines.count]
    vm_lines.select! { |l| !l.include? '---+---' }
    vm_lines.select! { |l| !l.empty? }
    vm_lines = vm_lines[0..-2]
    parse_vm_lines deployment_name, vm_lines
  end

  def get_deployment_names
    BoshVitals.logger.info "Getting deployment names ..."
    result = self.connection.execute_command("deployments")
    lines = result.split("\n")
    deployment_lines = lines[4..lines.count]
    deployment_lines.select! { |l| !l.include? '---+---' }
    deployment_lines.select! { |l| !l.empty? }
    deployment_lines = deployment_lines[0..-3]

    deployment_names = []
    deployment_lines.each do |l|
      splitted = l.split("|")
      deployment_names << splitted[1].strip unless splitted[1].strip.empty?
    end

    BoshVitals.logger.info "Deployments: #{deployment_names}"
    deployment_names
  end

  def fetch_vitals_record
    dep_names = get_deployment_names
    deployment_vitals = []
    dep_names.each do |dep|
      deployment_vitals << deployment(dep)
    end

    deployment_vitals.flatten!

    rec = {
      timestamp: Time.now.utc,
      bosh_host: self.connection.host,
      vitals: deployment_vitals
    }
  end

  protected

  def parse_vm_lines(deployment_name, vm_lines)
    vm_vitals = []
    vm_lines.each_with_index do |vline, index|
      next if vline[2].nil? || vline[2].strip.empty?
      splitted = vline.split("|")
      splitted = splitted[1,splitted.count]
      splitted.map! { |s| s.strip }

      splitted
      #  "| Job/index | State | Resource Pool | IPs | CID | Agent ID| Resurrection | DNS A records|Load | CPU  | CPU  | CPU | Memory Usage|Swap Usage|System |Ephemeral| Persistent |",

      vit = BoshVitals::Models::VmVitals.new
      vit.deployment_name = deployment_name
      vit.job_name = splitted[0].split("/").first unless splitted[0].strip.empty?
      vit.job_index = splitted[0].split("/").last unless splitted[0].strip.empty?
      vit.state = splitted[1] unless splitted[1].strip.empty?
      vit.resource_pool = splitted[2] unless splitted[2].strip.empty?
      vit.ips = splitted[3] unless splitted[3].strip.empty?
      vit.cid = splitted[4] unless splitted[4].strip.empty?
      vit.agent_id = splitted[5] unless splitted[5].strip.empty?
      vit.resurrection = splitted[6] unless splitted[6].strip.empty?
      vit.dns = splitted[7] unless splitted[7].strip.empty?

      vit.load_avg01 = splitted[8].split(",")[0].strip unless splitted[8].strip.empty?
      vit.load_avg05 = splitted[8].split(",")[1].strip unless splitted[8].strip.empty?
      vit.load_avg15 = splitted[8].split(",")[2].strip unless splitted[8].strip.empty?

      vit.cpu_user = splitted[9][0..-2] unless splitted[9].strip.empty?
      vit.cpu_sys = splitted[10][0..-2] unless splitted[10].strip.empty?
      vit.cpu_wait = splitted[11][0..-2] unless splitted[11].strip.empty?



      vit.mem = splitted[12].split("(").last.strip[0..-2] unless splitted[12].strip.empty?
      vit.mem_percent = splitted[12].split("(").first.strip[0..-2] unless splitted[12].strip.empty?

      vit.swap = splitted[13].split("(").last.strip[0..-2] unless splitted[13].strip.empty?
      vit.swap_percent = splitted[13].split("(").first.strip[0..-2] unless splitted[13].strip.empty?

      vit.disk_system_percent = splitted[14][0..-2] unless splitted[14].strip.empty?
      vit.disk_ephemeral_percent = splitted[15][0..-2] unless splitted[15].strip.empty?
      vit.disk_persistent_percent = splitted[16][0..-2] unless splitted[16].strip.empty?

      vm_vitals << vit
    end

    vm_vitals
  end
end
