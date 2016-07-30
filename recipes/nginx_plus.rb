include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/nginx.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    protocol: node['librato']['nginx_plus']['protocol'],
    host: node['librato']['nginx_plus']['host'],
    path: node['librato']['nginx_plus']['path'],
    verbose: node['librato']['nginx_plus']['verbose']
  )
  notifies :restart, 'service[collectd]', :delayed
end
