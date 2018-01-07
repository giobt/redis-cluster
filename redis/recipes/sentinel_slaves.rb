#
# Cookbook Name::       redis
# Description::         Configure redis slave nodes
# Recipe::              sentinel_slaves.rb
# Author::              Giorgio Balconi
#
# Copyright 2018, Giorgio Balconi
#

# Configure slave node templates
node[:redis][:ports].each do |port|
  # Change parameters for more different instances of redis
  node.default[:redis][:server][:port] = port
  node.default[:sentinel][:master_name] = "slave-#{port}"

  # Create configuration file for each sentinel slave instance
  template "#{node[:redis][:conf_dir]}/sentinel#{port}.conf" do
    source        "sentinel.conf.erb"
    owner         "root"
    group         "root"
    mode          "0644"
    variables     :port => node[:redis][:server][:port], :master_name => priority
  end

  # Start redis slave service instance
  execute 'redis-sentinel' do
    command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel#{port}.conf"
    user 'redis'
  end

  # Increase slave priority for every node
  priority = priority + 100
end
