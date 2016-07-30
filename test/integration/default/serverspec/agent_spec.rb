require 'serverspec'
set :backend, :exec

describe package('collectd-core') do
  it { should be_installed }
end

describe service('collectd') do
  it { should be_running }
end
