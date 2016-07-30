include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/mysql.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    databases: node['librato']['mysql']['databases']
  )
  notifies :restart, 'service[collectd]', :delayed
end
