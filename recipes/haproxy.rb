include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/haproxy.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    socket_file: node['librato']['haproxy']['socket_file'],
    proxies: node['librato']['haproxy']['proxies']
  )
  notifies :restart, 'service[collectd]', :delayed
end
