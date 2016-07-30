include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/redis.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    host: node['librato']['redis']['host'],
    port: node['librato']['redis']['port'],
    timeout: node['librato']['redis']['timeout']
  )
  notifies :restart, 'service[collectd]', :delayed
end
