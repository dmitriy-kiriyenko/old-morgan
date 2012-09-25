node['unicorn'] = {
  'installs'  => [ {
    'app_root' => '/var/www/apps/redtape/current',
    'run_service' => false,
    'user' => node['maintenance']['deploy_user']['name'],
    'group' => node['maintenance']['deploy_user']['group'],
    'pid' => "#{node['unicorn']['app_root']}/pids/unicorn.pid"
  } ]
}

include_recipe "unicorn"
