include_recipe 'librato::repo'

package 'collectd-core' do
  action :install
  version node['librato']['version']
end

service 'collectd' do
  action [:start, :enable]
  subscribes :restart, 'package[collectd-core]', :delayed
end

template "#{node['librato']['config_base']}/collectd.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    plugin_config_path: node['librato']['plugin_config_path'],
    hostname: node['librato']['hostname'],
    fqdn_lookup: node['librato']['fqdn_lookup'],
    interval: node['librato']['interval']
  )
  notifies :restart, 'service[collectd]', :delayed
end

template "#{node['librato']['plugin_config_path']}/logging.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    use_syslog: node['librato']['logging']['use_syslog'],
    use_log_file: node['librato']['logging']['use_log_file'],
    use_logstash: node['librato']['logging']['use_logstash']
  )
  notifies :restart, 'service[collectd]', :delayed
end

template "#{node['librato']['plugin_config_path']}/librato.conf" do
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    email: node['librato']['email'],
    token: node['librato']['token']
  )
  notifies :restart, 'service[collectd]', :delayed
end

default_plugins = node['librato']['default_plugins']

default_plugins.each do |plugin|
  template "#{node['librato']['plugin_config_path']}/#{plugin}.conf" do
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[collectd]', :delayed
  end
end
