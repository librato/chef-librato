include_recipe 'librato::agent'

template "#{node['librato']['plugin_config_path']}/varnish.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[collectd]', :delayed
end
