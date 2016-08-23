include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/mongodb.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    host: node['librato']['mongodb']['host'],
    port: node['librato']['mongodb']['port'],
    user: node['librato']['mongodb']['user'],
    password: node['librato']['mongodb']['password'],
    databases: node['librato']['mongodb']['databases'],
    name: node['librato']['mongodb']['name']
  )
  notifies :restart, 'service[collectd]', :delayed
end
