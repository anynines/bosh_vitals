con = BoshVitals::Bosh::Connection.new
con.login
fet = BoshVitals::Bosh::VitalFetcher.new con
fet.get_deployment_names
vitals_records = fet.fetch_vitals_record

# fetch a single deployments vm vitals
# fet.deployment "anynines-staging"

checker = BoshVitals::Checkers::VmVitalsChecker.new
checker.check_all vitals_records[:vitals]; nil
