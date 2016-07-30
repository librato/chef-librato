include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/docker.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    protocol: node['librato']['docker']['protocol'],
    host: node['librato']['docker']['host'],
    port: node['librato']['docker']['port']
  )
  notifies :restart, 'service[collectd]', :delayed
end
