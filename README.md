# aws-micro-swap Cookbook

This cookbook sets up and enables a swap on micro EC2 instances.

After writing this whole cookbook, setting up tests, and getting this to v1.0.0, @sethvargo’s [swap cookbook](https://github.com/sethvargo-cookbooks/swap) was discovered, which provides all the functionality of this cookbook as a resouce.

# Requirements

Must be executed on a `t1.micro` EC2 instance. Otherwise, nothing will occur, as other instance types have swap set up already.

# Usage

Just include `aws-micro-swap::default` in your node’s `run_list`.

# Attributes

* `node['aws-micro-swap']['swap-path']`

# Recipes

## default

1. Check if we’re on an `t1.micro` EC2 instance.
2. Create the swapfile if it does not exist
3. Set up the swapfile
4. Enable the swap
5. Add the swapfile to `/etc/fstab`

# Authors

Authors: Jeff Byrnes <thejeffbyrnes@gmail.com>
