node['unicorn'] = {
  'installs'  => [ {
    'app_root' => '/var/www/apps/redtape/current',
    'run_service' => false,
    'user' => node['maintenance']['deploy_user']['name'],
    'group' => node['maintenance']['deploy_user']['group']
  } ]
}

include_recipe "unicorn"
