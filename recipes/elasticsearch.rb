include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/elasticsearch.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    protocol: node['librato']['elasticsearch']['protocol'],
    host: node['librato']['elasticsearch']['host'],
    port: node['librato']['elasticsearch']['port'],
    cluster_name: node['librato']['elasticsearch']['cluster_name'],
    verbose: node['librato']['elasticsearch']['verbose']
  )
  notifies :restart, 'service[collectd]', :delayed
end
