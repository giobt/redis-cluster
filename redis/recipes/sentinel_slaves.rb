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
  sentinel_port = 20000 + port
  node.default[:redis][:server][:port] = port
  node.default[:sentinel][:master_name] = "slave-#{port}"

  # Create configuration file for each sentinel slave instance
  template "#{node[:redis][:conf_dir]}/sentinel#{port}.conf" do
    source        "sentinel.conf.erb"
    owner         "root"
    group         "root"
    mode          "0644"
    variables     :sentinel_port => sentinel_port, :port => node[:redis][:server][:port], :master_name => node[:sentinel][:master_name]
  end

  # Start redis slave service instance
  execute 'redis-sentinel' do
    command "redis-sentinel #{node[:redis][:conf_dir]}/sentinel#{port}.conf"
    user 'root'
  end
end
