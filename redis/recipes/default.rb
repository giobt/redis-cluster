#
# Cookbook Name::       redis
# Description::         Install redis_server and configure master node
# Recipe::              default
# Author::              Giorgio Balconi
#
# Copyright 2018, Giorgio Balconi
#

# Include apt recipe to add redis repository
include_recipe 'apt'

# Add redis repository
apt_repository 'redis-server' do
  uri          'ppa:chris-lea/redis-server'
  distribution node['lsb']['codename']
end

# Install redis_server
package 'redis-server'

# Configure master node template
template "#{node[:redis][:conf_dir]}/redis.conf" do
  source        "redis.conf.erb"
  owner         "root"
  group         "root"
  mode          "0644"
  variables     :redis => node[:redis], :redis_server => node[:redis][:server]
end
