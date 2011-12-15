# NOTE: Doesn't support non-RedHat distros yet.
# TODO: Support Ubuntu/Debian, if anyone really cares?
require_recipe "iptables"

package node.services.couchdb.package_names.server do
  action :install
end

service node.services.couchdb.service_name do
  action :enable
  supports :restart => true
end

["local.ini"].each do |file|
  cookbook_file File.join(node.services.couchdb.cfg_dir, file) do
    action :create
    source file
    owner node.services.couchdb.owner
    group node.services.couchdb.group
    notifies :restart, 
      resources(:service => node.services.couchdb.service_name)
  end
end

service node.services.couchdb.service_name do
  action :restart
end

iptables_rule "couchdb:#{node.services.couchdb.port}" do
  # chain specific to CentOS/RHEL
  chain "RH-Firewall-1-INPUT"
  state "NEW"
  protocol "tcp"
  dport node.services.couchdb.port
  target "ACCEPT"
end
