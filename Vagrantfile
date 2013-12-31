# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = 'aws-micro-swap-berkshelf'

  config.vm.box = 'dummy'
  config.vm.box_url = 'https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box'

  # Install Chef using Chef Omnibus
  config.omnibus.chef_version = :latest

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = "#{ENV['AWS_ACCESS_KEY_JB']}"
    aws.secret_access_key = "#{ENV['AWS_SECRET_KEY_JB']}"
    aws.keypair_name = 'macbook-pro'

    aws.region = 'us-east-1'
    aws.ami = 'ami-bba18dd2' # Amazon Linux 2013.09 x86_64 PV EBS
    # aws.ami = 'ami-bd6d40d4' # Ubuntu 12.04 LTS precise64 instance-backed

    aws.instance_type = 't1.micro'

    aws.security_groups = 'AWS-OpsWorks-Blank-Server'
    aws.tags = {
      'Name' => "test-#{config.vm.hostname}",
      'Role' => 'vagrant-testing',
      'Env' => 'prod'
    }

    aws.user_data = "#!/bin/bash\n" +
      "echo 'Defaults:ec2-user !requiretty' > " +
      "/etc/sudoers.d/999-vagrant-cloud-init-requiretty && " +
      "chmod 440 /etc/sudoers.d/999-vagrant-cloud-init-requiretty\n"

    override.ssh.username = 'ec2-user'
    # override.ssh.username = 'ubuntu'
    override.ssh.private_key_path = "#{ENV['HOME']}/.ssh/id_rsa"
  end

  config.vm.provision :chef_solo do |chef|
    chef.json = {}

    chef.log_level = :debug

    chef.run_list = [
      'recipe[aws-micro-swap::default]'
    ]
  end
end
