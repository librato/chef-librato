require 'chefspec'

describe 'librato::agent' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'Installs correct agent package & version' do
    expect(chef_run).to install_package('collectd')
  end
end
