#
# Cookbook Name::       redis
# Description::         Base configuration for redis
# Recipe::              default
# Author::              Benjamin Black (<b@b3k.us>)
#
# Copyright 2009, Benjamin Black
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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

# Configure slave node templates
node[:redis][:slave] = "yes"
node[:redis][:ports].each do |port|
  node[:redis][:server][:port] = port
  template "#{node[:redis][:conf_dir]}/redis.conf" do
    source        "redis.conf.erb"
    owner         "root"
    group         "root"
    mode          "0644"
    variables     :redis => node[:redis], :redis_server => node[:redis][:server]
  end
end
