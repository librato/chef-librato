include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/postgresql.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    socket_file: node['librato']['postgresql']['socket_file'],
    user: node['librato']['postgresql']['user'],
    databases: node['librato']['postgresql']['databases']
  )
  notifies :restart, 'service[collectd]', :delayed
end
