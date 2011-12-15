require_recipe "postgresql::repo"

# NOTE: Doesn't support non-RedHat distros yet.
# TODO: Support Ubuntu/Debian.

package node.services.postgresql.package_names.odbc do
  action :install
end
