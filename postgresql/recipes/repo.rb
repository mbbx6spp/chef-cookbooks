# NOTE: Doesn't support non-RedHat distros yet.
# TODO: Support Ubuntu/Debian.

node.services.postgresql[:repo_rpm_path] = File.join(
  node.services.postgresql.tmp_dir, 
  node.services.postgresql.repo_rpm_file)

remote_file node.services.postgresql.repo_rpm_path do
  source [node.services.postgresql.repo_rpm_url, 
          node.services.postgresql.repo_rpm_file].join('/')
  mode "0644"
  checksum node.services.postgresql.repo_rpm_sum
end

package node.services.postgresql.repo_rpm_path do
  source node.services.postgresql.repo_rpm_path
  action :install
  options "--nogpgcheck"
end

