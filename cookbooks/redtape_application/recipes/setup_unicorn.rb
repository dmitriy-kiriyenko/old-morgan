node['unicorn'] = {
  'installs'  => [ {
    'app_root' => '/var/www/apps/redtape/current',
    'run_service' => false,
    'user' => node['redtape_application']['deploy']['user'],
    'group' => node['redtape_application']['deploy']['group']
  } ]
}

include_recipe "unicorn"
