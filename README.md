# Librato Cookbook

This cookbook configures the Librato Agent and plugins.

## Supported Platforms

* RHEL 6 / CentOS 6
* RHEL 7 / CentOS 7
* Fedora 23
* Amazon Linux 2016.03
* Ubuntu 12.04
* Ubuntu 14.04
* Ubuntu 15.04
* Ubuntu 15.10
* Ubuntu 16.04
* Debian 7
* Debian 8

## Usage

### Quickstart

1. Set the attributes `node['librato']['email']` and `node['librato']['token']`
2. Include `librato` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[librato::default]"
  ]
}
```

This will install the Agent and set up the default plugins (`cpu`, `df`, `disk`, `swap`, `memory`, `load`).

### Supported Plugins

* `cpu`
* `df`
* `memory`
* `load`
* `disk`
* `swap`
* `apache`
* `nginx`
* `nginx_plus`
* `jvm`
* `memcached`
* `varnish`
* `zookeeper`
* `docker`
* `elasticsearch`
* `mongodb`
* `postgresql`
* `mysql`
* `redis`
* `haproxy`

### Including a plugin

To include a plugin, include the recipe in your run list:

```json
{
  "run_list": [
    "recipe[librato::apache]"
  ]
}
```

All of the plugins have sane defaults, but you can modify them via the attributes.

### Using a third-party or upstream plugin that isn't available here

To use a plugin that this cookbook does not directly support (see list of plugins above),
create a wrapper cookbook and drop the config file and plugin file in the appropriate locations.

Config location: `/opt/collectd/etc/collectd.conf.d/`

Plugin location: `/opt/collectd/share/collectd/`

## Recipes & their attributes

Each plugin has a set of attributes that you can override.

### Recipe: `apache`
  - `node['librato']['apache']['protocol']`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.

  - `node['librato']['apache']['host']`
      
    **Type**: string
      
    The hostname to use. Defaults to `localhost`.
  - `node['librato']['apache']['path']`
    
    **Type**: string
    
    The path to the status page. Defaults to `/server-status`. `?auto` is automatically appended, so no need to include it.

  - `node['librato']['apache']['user']`
    
    **Type**: string
    
    The username to use for password-protected status pages. Defaults to empty.
  - `node['librato']['apache']['password']`
    
    **Type**: string
    
    The password to use for password-protected status pages. Defaults to empty.

### Recipe: `docker`
  - `node['librato']['docker']['protocol']`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.

  - `node['librato']['docker']['host']`
    
    **Type**: string
    
    The Docker hostname. Defaults to `localhost`.
  
  - `node['librato']['docker']['port']`
    
    **Type**: string
    
    The Docker port. Defaults to `2735`

### Recipe: `elasticsearch`
  
  - `node['librato']['elasticsearch']['protocol']`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.
  
  - `node['librato']['elasticsearch']['host']`
    
    **Type**: string
    
    The ElasticSearch hostname. Defaults to `localhost`.
  
  - `node['librato']['elasticsearch']['port']`
    
    **Type**: string
    
    The ElasticSearch port. Defaults to `9200`.
  
  - `node['librato']['elasticsearch']['cluster_name']`
    
    **Type**: string
    
    The ElasticSearch cluster name, if set. Defaults to `nil`.
  
  - `node['librato']['elasticsearch']['verbose']`
    
    **Type**: true/false
    
    Verbosity trigger of the plugin. Defaults to `true`.

### Recipe: `haproxy`
  - `node['librato']['haproxy']['socket_file']`
    
    **Type**: string
    
    The HAProxy socket file. Defaults to `/run/haproxy/admin.sock`.
  
  - `node['librato']['haproxy']['proxies']`
    
    **Type**: array
    
    The default proxies to collect. Defaults to `server`, `frontend`, `backend`.

### Recipe: `jvm`
  - `node['librato']['jvm']['host']`
    
    **Type**: string
    
    The JVM host. Defaults to `localhost`.
  
  - `node['librato']['jvm']['service_url']`
    
    **Type**: string
    
    The JVM service URL to query. Defaults to `service:jmx:rmi:///jndi/rmi://localhost:17264/jmxrmi`.
  
  - `node['librato']['jvm']['mbeans']`
    
    **Type**: hash
    
    Additional mbeans to collect. Defaults to empty.
    
    Format of the hash is:
    ```ruby
    mbeans = [
      {
        'name': 'mbean name',
        'object_name': 'object name',
        'instance_prefix': 'instance prefix (optional)',
        'instance_from': 'instance from (optional)',
        'values': [
          {
            'type': 'value type',
            'table': true|false,
            'attribute': 'attribute'
            'instance_prefix': 'instance prefix (optional)',
            'instance_from': 'instance from (optional)'
          }
        ]
      }
    ]
    ```

### Recipe: `memcached`
  - `node['librato']['memcached']['host']`
    
    **Type**: string
    
    The memcached hostname. Defaults to `localhost`.
  
  - `node['librato']['memcached']['port']`
    
    **Type**: string
    
    The memcached port. Defaults to `11211`.

### Recipe: `mongodb`
  - `node['librato']['mongodb']['host']`
    
    **Type**: string
    
    The MongoDB hostname. Defaults to `localhost`.
  
  - `node['librato']['mongodb']['port']`
    
    **Type**: string
    
    The MongoDB port. Defaults to `27017`.
  
  - `node['librato']['mongodb']['user']`
    
    **Type**: string
    
    The MongoDB username to connect with. Defaults to `nil`.
  
  - `node['librato']['mongodb']['password']`
    
    **Type**: string
    
    The MongoDB password to connect with. Defaults to `nil`.
  
  - `node['librato']['mongodb']['databases']`
    
    **Type**: array
    
    Databases to collect metrics for. Defaults to empty. `admin` database is automatically included in the array.
  
  - `node['librato']['mongodb']['name']`
    
    **Type**: string
    
    Set the name of the plugin instance. Defaults to `mongodb`.

### Recipe: `mysql`
  - `node['librato']['mysql']['databases']`
    
    **Type**: array of hashes
    
    Databases to collect metrics for. Defaults to empty.
    
    Format of the array:
    ```ruby
    databases = [
                  {
                    name: 'mydb',
                    host: 'localhost',
                    port: 3306,
                    user: '',
                    password: '',
                    innodb_stats: true,
                    slave_stats: false
                  }
                ]
    ```

### Recipe: `nginx`
  - `node['librato']['nginx']['protocol']`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.
  
  - `node['librato']['nginx']['host']`
    
    **Type**: string
    
    The hostname to use. Defaults to `localhost`.
  
  - `node['librato']['nginx']['path']`
    
    **Type**: string
    
    The path to the status page. Defaults to `/basic_status`.

### Recipe: `nginx_plus`
  - `node['librato']['nginx_plus']['protocol']`
    
    **Type**: string
    
    The protocol to use. Defaults to `http`. Change this to `https` if you require SSL.
  
  - `node['librato']['nginx_plus']['host']`
    
    **Type**: string
    
    The hostname to use. Defaults to `localhost`.
  
  - `node['librato']['nginx_plus']['path']`
    
    **Type**: string
    
    The path to the status page. Defaults to `/status`.
  
  - `node['librato']['nginx_plus']['verbose']`
    
    **Type**: string
    
    Verbosity on/off for the plugin. Defaults to `false`.

### Recipe: `postgresql`
  - `node['librato']['postgresql']['socket_file']` = '/var/run/postgresql'
    
    **Type**: string
    
    The PostgreSQL socket file. Defaults to `/var/run/postgresql`.
  
  - `node['librato']['postgresql']['user']` = 'postgresql'
    
    **Type**: string
    
    The PostgreSQL user to connect as. Defaults to `postgresql`.
  
  - `node['librato']['postgresql']['databases']` = []
    
    **Type**: array of hashes
    
    The databases to collect metrics for. Defaults to empty.
    
    The format of the array is:
    ```ruby
    databases = [
                  {
                    name: 'mydb',
                    instance: 'baz',
                    host: 'localhost',
                    port: 5432,
                    user: '',
                    password: '',
                    ssl_mode: 'prefer'
                  }
                ]
    ```

### Recipe: `redis`
  - `node['librato']['redis']['host']`
    
    **Type**: string
    
    The Redis hostname. Defaults to `localhost`.
  
  - `node['librato']['redis']['port']`
    
    **Type**: string
    
    The Redis port. Defaults to `6379`.
  
  - `node['librato']['redis']['timeout']`
    
    **Type**: string
    
    The timeout for connecting to Redis in milliseconds. Defaults to `2000`.

### Recipe: `varnish`
  
  Varnish has no configurable attributes.

### Recipe: `zookeeper`
  - `node['librato']['zookeeper']['host']`
    
    **Type**: string
    
    The ZooKeeper hostname. Defaults to `localhost`.
  
  - `node['librato']['zookeeper']['port']`
    
    **Type**: string
    
    The ZooKeeper port. Defaults to `2181`.

## Global Attributes

- `node['librato']['email']`
  
  **Type**: string
  
  The email to use for sending metrics. Use in conjunction with `token`. This attribute is required and defaults to empty.

- `node['librato']['token']`
  
  **Type**: string
  
  The API token to use for sending metrics. Use in conjunction with `email`. This attribute is required and defaults to empty.

- `node['librato']['version']`
  
  **Type**: string
  
  The version of the Librato Agent to install.

- `node['librato']['repo_url']`
  
  **Type**: string
  
  The base URL for the packages. Defaults to Librato's repo URL `https://packagecloud.io/librato/`.

- `node['librato']['repo_base']`
  
  **Type**: string
  
  The repo base to use. Defaults to Librato's repo collection `librato-collectd`.

- `node['librato']['config_base']`
  
  **Type**: string
  
  The base path for collectd's config files. Defaults to `/opt/collectd/etc`.

- `node['librato']['plugin_config_path']`
  
  **Type**: string
  
  The path for collectd's plugin configs. Defaults to `/opt/collectd/etc/collectd.conf.d`.

- `node['librato']['hostname']`
  
  **Type**: string
  
  The hostname to use for the node. Defaults to the FQDN of the node (`node['fqdn']`).

- `node['librato']['fqdn_lookup']`
  
  **Type**: true/false
  
  Perform an FQDN lookup or not. Defaults to `false`.

- `node['librato']['interval']`
  
  **Type**: integer
  
  The global plugin polling interval in seconds. Defaults to `60`.

- `node['librato']['use_log_file']`
  
  **Type**: true/false
  
  Write collectd logs to a file. Defaults to `true`.

- `node['librato']['use_syslog']`
  
  **Type**: true/false
  
  Write collectd logs to syslog. Defaults to `false`.

- `node['librato']['use_logstash']`
  
  **Type**: true/false
  
  Write collectd logs to a logstash-formatted file. Defaults to `false`.

- `node['librato']['log_file']['log_level']`
  
  **Type**: string
  
  The log level to use for `log_file`. Defaults to `info`.

- `node['librato']['log_file']['filename']`
  
  **Type**: string
  
  The filename to use for `log_file`. Defaults to `/opt/collectd/var/log/collectd.log`.

- `node['librato']['log_file']['timestamp']`
  
  **Type**: true/false
  
  Use timestamps in the log file or not. Defaults to `true`.

- `node['librato']['log_file']['print_severity']`
  
  **Type**: true/false
  
  Include severity levels in the log file or not. Defaults to `true`.

- `node['librato']['syslog']['log_level']`
  
  **Type**: string
  
  The log level to use for `syslog`. Defaults to `info`.

- `node['librato']['logstash']['log_level']`
  
  **Type**: string
  
  The log level to use for `logstash`. Defaults to `info`.

- `node['librato']['logstash']['filename']`
  
  **Type**: string
  
  The file name to use for `logstash`. Defaults to `/opt/collectd/var/log/collectd.json.log`

- `node['librato']['default_plugins']`
  
  **Type**: array
  
  A list of default plugins to include. Defaults to: `cpu`, `df`, `disk`, `swap`, `memory`, `load`.

## Testing

### Unit tests

No unit tests are written at this time.

### Integration tests

1. Run `kitchen test`
2. Take a break--it takes a bit to run the full suite.

#### Testing Amazon Linux

Testing Amazon Linux through `test-kitchen` requires a bit more setup:

1. Ensure `kitchen-ec2` is installed: `chef gem install kitchen-ec2`
2. Update `.kitchen.yml` to have the correct AWS key ID you're going to use
3. Set `security_group_ids` in the driver section to include a security group accessible from your laptop. Not setting this will use the `default` security group.
4. Set `transport.ssh_key` to the path of your SSH key. It looks for `id_rsa` by default.

## License and Authors

**Author:** Mike Julian (@mjulian)
