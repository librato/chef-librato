include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/memcached.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    host: node['librato']['memcached']['host'],
    path: node['librato']['memcached']['port']
  )
  notifies :restart, 'service[collectd]', :delayed
end
