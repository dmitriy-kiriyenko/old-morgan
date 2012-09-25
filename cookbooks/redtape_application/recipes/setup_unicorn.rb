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

        # The following is only recommended for memory/DB-constrained
        # installations.  It is not needed if your system can house
        # twice as many worker_processes as you have configured.
        #
        # This allows a new master process to incrementally
        # phase out the old master process with SIGTTOU to avoid a
        # thundering herd (especially in the "preload_app false" case)
        # when doing a transparent upgrade.  The last worker spawned
        # will then kill off the old master process with a SIGQUIT.
        old_pid = "#{pid}.oldbin"
        if old_pid != server.pid
          begin
            sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
            Process.kill(sig, File.read(old_pid).to_i)
          rescue Errno::ENOENT, Errno::ESRCH
          end
        end
        #
        # Throttle the master from forking too quickly by sleeping.  Due
        # to the implementation of standard Unix signal handlers, this
        # helps (but does not completely) prevent identical, repeated signals
        # from being lost when the receiving process is busy.
        # sleep 1
      RUBY
      'after_fork' => <<-RUBY
        # per-process listener ports for debugging/admin/migrations
        # addr = "127.0.0.1:#\{9293 + worker.nr\}"
        # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

        # the following is *required* for Rails + "preload_app true",
        defined?(ActiveRecord::Base) and
          ActiveRecord::Base.establish_connection

        # if preload_app is true, then you may also want to check and
        # restart any other shared sockets/descriptors such as Memcached,
        # and Redis.  TokyoCabinet file handles are safe to reuse
        # between any number of forked children (assuming your kernel
        # correctly implements pread()/pwrite() system calls)
      RUBY
    }
  } ]
}

include_recipe "unicorn"
