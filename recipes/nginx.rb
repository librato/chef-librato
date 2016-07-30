include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/nginx.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    protocol: node['librato']['nginx']['protocol'],
    host: node['librato']['nginx']['host'],
    path: node['librato']['nginx']['path']
  )
  notifies :restart, 'service[collectd]', :delayed
end
