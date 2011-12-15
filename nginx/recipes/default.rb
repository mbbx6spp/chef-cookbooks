package "nginx" do
  action :install
end

service "nginx" do
  action :enable
  supports :restart => true
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  variables :hosts => node[:hosts]
  notifies :restart, resources(:service => "nginx")
end

template "/etc/nginx/conf.d/log.conf" do
  source "nginx.log.conf.erb"
  variables :hosts => node[:hosts]
  notifies :restart, resources(:service => "nginx")
end

service "nginx" do
  action :restart
end

