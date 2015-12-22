con = BoshVitals::Bosh::Connection.new
con.login
ch = BoshVitals::Bosh::VitalChecker.new con
ch.get_deployment_names
ch.fetch_vitals_record

ch.deployment "anynines-staging"
