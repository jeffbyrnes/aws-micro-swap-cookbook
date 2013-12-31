#
# Cookbook Name:: aws-micro-swap
# Recipe:: default
#
# Copyright 2013, Jeff Byrnes
#
# All rights reserved - Do Not Redistribute
#

if node.attribute?("ec2")
  if node["ec2"]["instance_type"] == "t1.micro"
    swapfile = "#{swapfile}"

    # Create the swapfile if it does not exist
    execute "create_swapfile" do
      command "dd if=/dev/zero of=#{swapfile} bs=1M count=1024"
      creates "#{swapfile}"
      notifies :run, "execute[setup_swap]"
    end

    # Set up the swapfile
    execute "setup_swap" do
      command "mkswap #{swapfile}"
      notifies :run, "execute[enable_swap]"
    end

    # Enable the swap
    execute "enable_swap" do
      command "swapon #{swapfile}"
      notifies :run, "mount[#{swapfile}]"
    end

    # Add the swapfile to /etc/fstab
    mount "#{swapfile}" do
      device_type :label
      fstype "swap"
      action :enable
    end
  end
end

