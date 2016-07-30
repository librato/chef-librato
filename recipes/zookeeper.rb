include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/zookeeper.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    host: node['librato']['zookeeper']['host'],
    port: node['librato']['zookeeper']['port']
  )
  notifies :restart, 'service[collectd]', :delayed
end
