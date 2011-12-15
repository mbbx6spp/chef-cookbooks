require_recipe "postgresql::repo"

# NOTE: Doesn't support non-RedHat distros yet.
# TODO: Support Ubuntu/Debian.

package node.services.postgresql.package_names.server do
  action :install
end

execute "/sbin/service #{node.services.postgresql.service_name} initdb" do
  action :run
  not_if { ::FileTest.exist?(File.join(node.services.postgresql.data_dir, "PG_VERSION")) }
end

service node.services.postgresql.service_name do
  action :enable
  supports :restart => true
end

["pg_hba.conf", "postgresql.conf"].each do |file|
  cookbook_file File.join(node.services.postgresql.data_dir, file) do
    action :create
    source file
    owner node.services.postgresql.owner
    group node.services.postgresql.group
    notifies :restart, 
      resources(:service => node.services.postgresql.service_name)
  end
end

service node.services.postgresql.service_name do
  action :restart
end

