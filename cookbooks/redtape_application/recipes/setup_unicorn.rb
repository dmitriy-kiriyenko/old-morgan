pid = "#{node['unicorn']['app_root']}/pids/unicorn.pid"

node['unicorn'] = {
  'installs'  => [ {
    'app_root' => '/var/www/apps/redtape/current',
    'run_service' => false,
    'user' => node['maintenance']['deploy_user']['name'],
    'group' => node['maintenance']['deploy_user']['group'],
    'pid' => pid,
    'config' => {
      'preload_app' => true,
      'before_fork' => <<-RUBY,
        # the following is highly recomended for Rails + "preload_app true"
        # as there's no need for the master process to hold a connection
        defined?(ActiveRecord::Base) and
          ActiveRecord::Base.connection.disconnect!
      RUBY
      'after_fork' => <<-RUBY
        # the following is *required* for Rails + "preload_app true",
        defined?(ActiveRecord::Base) and
          ActiveRecord::Base.establish_connection
      RUBY
    }
  } ]
}

include_recipe "unicorn"
