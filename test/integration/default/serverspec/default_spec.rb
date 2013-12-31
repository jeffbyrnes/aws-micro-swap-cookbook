require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe file('/mnt/swapfile.swap') do
  it { should be_file }
end

describe file('/etc/fstab') do
  its(:content) { should match /\/mnt\/swapfile.swap/ }
end

describe command('swapon -s') do
  it { should return_stdout /\/mnt\/swapfile.swap/ }
end
