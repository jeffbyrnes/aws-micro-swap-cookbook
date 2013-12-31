#
# Cookbook Name:: aws-micro-swap
# Recipe:: default
#
# Copyright (C) 2013 Jeff Byrnes
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node.attribute?('ec2') && node['ec2']['instance_type'] == 't1.micro'
  swapfile = node['aws-micro-swap']['swap-path']

  # Create the swapfile if it does not exist
  execute 'create_swapfile' do
    command "dd if=/dev/zero of=#{swapfile} bs=1M count=1024"
    creates swapfile
    notifies :run, 'execute[setup_swap]'
  end

  # Set up the swapfile
  execute 'setup_swap' do
    command "mkswap #{swapfile}"
    notifies :run, 'execute[enable_swap]'
    action :nothing
  end

  # Enable the swap
  execute 'enable_swap' do
    command "swapon #{swapfile}"
    notifies :enable, "mount[#{swapfile}]"
    action :nothing
  end

  # Add the swapfile to /etc/fstab
  mount swapfile do
    device 'swap'
    device_type :label
    fstype 'swap'
    action :nothing
  end
end
