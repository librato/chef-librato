include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/jvm.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    service_url: node['librato']['jvm']['service_url'],
    host: node['librato']['jvm']['host'],
    mbeans: node['librato']['jvm']['mbeans']
  )
  notifies :restart, 'service[collectd]', :delayed
end
