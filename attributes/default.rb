node.default['librato']['repo_url'] = 'https://packagecloud.io/librato/'
node.default['librato']['repo_base'] = node['platform'] == 'amazon' ? 'librato-amazonlinux-collectd' : 'librato-collectd'

case node['platform']
when 'debian', 'ubuntu'
  node.default['librato']['version'] = '5.7.1-librato1.413'
when 'centos', 'redhat', 'fedora', 'amazon'
  node.default['librato']['version'] = '5.7.1-librato1.413-0'
end

node.default['librato']['email'] = ''
node.default['librato']['token'] = ''

node.default['librato']['config_base'] = '/opt/collectd/etc'
node.default['librato']['plugin_config_path'] = '/opt/collectd/etc/collectd.conf.d'
node.default['librato']['hostname'] = nil
node.default['librato']['fqdn_lookup'] = true
node.default['librato']['interval'] = 60

node.default['librato']['logging']['use_log_file'] = true
node.default['librato']['logging']['use_syslog'] = false
node.default['librato']['logging']['use_logstash'] = false
node.default['librato']['logging']['log_file']['log_level'] = 'info'
node.default['librato']['logging']['log_file']['filename'] = '/opt/collectd/var/log/collectd.log'
node.default['librato']['logging']['log_file']['timestamp'] = true
node.default['librato']['logging']['log_file']['print_severity'] = false
node.default['librato']['logging']['syslog']['log_level'] = 'info'
node.default['librato']['logging']['logstash']['log_level'] = 'info'
node.default['librato']['logging']['logstash']['filename'] = '/opt/collectd/var/log/collectd.json.log'

node.default['librato']['default_plugins'] = %w(cpu df disk swap memory load)

node.default['librato']['apache']['protocol'] = 'http'
node.default['librato']['apache']['host'] = 'localhost'
node.default['librato']['apache']['path'] = '/server-status'
node.default['librato']['apache']['user'] = nil
node.default['librato']['apache']['password'] = nil

node.default['librato']['nginx']['protocol'] = 'http'
node.default['librato']['nginx']['host'] = 'localhost'
node.default['librato']['nginx']['path'] = '/basic_status'

node.default['librato']['nginx_plus']['protocol'] = 'http'
node.default['librato']['nginx_plus']['host'] = 'localhost'
node.default['librato']['nginx_plus']['path'] = '/status'
node.default['librato']['nginx_plus']['verbose'] = false

node.default['librato']['memcached']['host'] = 'localhost'
node.default['librato']['memcached']['port'] = '11211'

node.default['librato']['elasticsearch']['protocol'] = 'http'
node.default['librato']['elasticsearch']['host'] = 'localhost'
node.default['librato']['elasticsearch']['port'] = '9200'
node.default['librato']['elasticsearch']['cluster_name'] = nil
node.default['librato']['elasticsearch']['verbose'] = true

node.default['librato']['mongodb']['host'] = 'localhost'
node.default['librato']['mongodb']['port'] = '27017'
node.default['librato']['mongodb']['user'] = nil
node.default['librato']['mongodb']['password'] = nil
node.default['librato']['mongodb']['databases'] = []
node.default['librato']['mongodb']['name'] = 'mongodb'

node.default['librato']['zookeeper']['host'] = 'localhost'
node.default['librato']['zookeeper']['port'] = '2181'

node.default['librato']['haproxy']['socket_file'] = '/run/haproxy/admin.sock'
node.default['librato']['haproxy']['proxies'] = %w(server frontend backend)

node.default['librato']['redis']['host'] = 'localhost'
node.default['librato']['redis']['port'] = '6379'
node.default['librato']['redis']['timeout'] = '2000'

node.default['librato']['mysql']['databases'] = []

node.default['librato']['postgresql']['databases'] = []
node.default['librato']['postgresql']['socket_file'] = '/var/run/postgresql'
node.default['librato']['postgresql']['user'] = 'postgresql'

node.default['librato']['docker']['protocol'] = 'http'
node.default['librato']['docker']['host'] = 'localhost'
node.default['librato']['docker']['port'] = '2735'

node.default['librato']['jvm']['host'] = 'localhost'
node.default['librato']['jvm']['service_url'] = 'service:jmx:rmi:///jndi/rmi://localhost:17264/jmxrmi'
node.default['librato']['jvm']['mbeans'] = []
