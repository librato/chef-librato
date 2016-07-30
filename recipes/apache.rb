include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/apache.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    protocol: node['librato']['apache']['protocol'],
    host: node['librato']['apache']['host'],
    path: node['librato']['apache']['path'],
    user: node['librato']['apache']['user'],
    password: node['librato']['apache']['password']
  )
  notifies :restart, 'service[collectd]', :delayed
end
