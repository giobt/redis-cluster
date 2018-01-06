#
# Locations
#

default[:redis][:conf_dir]          = "/etc/redis"
default[:redis][:log_dir]           = "/var/log/redis"
default[:redis][:data_dir]          = "/var/lib/redis"

default[:redis][:home_dir]          = "/usr/local/share/redis"
default[:redis][:pid_file]          = "/var/run/redis.pid"

default[:redis][:db_basename]       = "dump.rdb"

default[:redis ][:user]              = 'redis'
default[:users ]['redis'][:uid]      = 335
default[:groups]['redis'][:gid]      = 335

#
# Server
#

default[:redis][:server][:addr]     = "0.0.0.0"
default[:redis][:server][:port]     = "6379"

#
# Install
#

default[:redis][:version]           = "4.0.6"
default[:redis][:release_url]       = "http://download.redis.io/releases/redis-4.0.6.tar.gz"

#
# Tunables
#

default[:redis][:server][:timeout]  = "300"
default[:redis][:glueoutputbuf]     = "yes"

default[:redis][:saves]             = [["900", "1"], ["300", "10"], ["60", "10000"]]

default[:redis][:shareobjects]      = "no"
if (node[:redis][:shareobjects] == "yes")
  default[:redis][:shareobjectspoolsize] = 1024
end

#
# Replication
#

default[:redis][:ports]             = ["6380", "6381", "6382"]
default[:redis][:slave]             = "no"
default[:redis][:master_server]   = "127.0.0.1"
default[:redis][:master_port]     = "6379"
