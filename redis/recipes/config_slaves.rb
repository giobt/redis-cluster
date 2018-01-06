#
# Cookbook Name::       redis
# Description::         Configure redis slave nodes
# Recipe::              default
# Author::              Giorgio Balconi
#
# Copyright 2018, Giorgio Balconi
#

# Include apt recipe to add redis repository
include_recipe 'apt'

# Configure slave node templates
priority = 100
node.default[:redis][:slave] = "yes"
node[:redis][:ports].each do |port|
  # Change parameters for more different instances of redis
  node.default[:redis][:pid_file]          = "/var/run/redis-#{port}.pid"
  node.default[:redis][:server][:port]     = port
  node.default[:redis][:log_dir]           = "/var/log/redis-#{port}"
  node.default[:redis][:data_dir]          = "/var/lib/redis-#{port}"

  # Create log directory for redis slave
  directory node[:redis][:log_dir] do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  # Create lib directory for redis slave
  directory node[:redis][:data_dir] do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  # Create configuration file for each slave redis instance
  template "#{node[:redis][:conf_dir]}/redis#{port}.conf" do
    source        "redis.conf.erb"
    owner         "root"
    group         "root"
    mode          "0644"
    variables     :redis => node[:redis], :redis_server => node[:redis][:server], :priority => priority
  end
  priority = priority + 100
end
