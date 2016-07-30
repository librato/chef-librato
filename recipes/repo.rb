case node['platform']
when 'debian', 'ubuntu'
  include_recipe 'apt'

  apt_repository "librato_#{node['librato']['repo_base']}" do
    uri "#{node['librato']['repo_url']}/#{node['librato']['repo_base']}/#{node['platform']}/"
    components ['main']
    distribution node['lsb']['codename']
    deb_src true
    key 'https://packagecloud.io/gpg.key'
  end

  apt_preference 'collectd' do
    pin          'release l=librato-collectd'
    pin_priority '1001'
  end

  apt_preference 'collectd-core' do
    pin          'release l=librato-collectd'
    pin_priority '1001'
  end

when 'centos', 'redhat', 'fedora', 'amazon'
  include_recipe 'yum'
  include_recipe 'yum-epel'

  yum_repository "librato_#{node['librato']['repo_base']}" do
    description "librato_#{node['librato']['repo_base']}"
    baseurl "#{node['librato']['repo_url']}/#{node['librato']['repo_base']}/el/$releasever/$basearch"
    gpgcheck false
    # gpgkey 'https://packagecloud.io/gpg.key'
    action :create
  end

else
  Chef::Log.error("Unsupported operating system: #{node['platform']}")
end
