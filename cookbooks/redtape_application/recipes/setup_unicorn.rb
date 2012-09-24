node['unicorn'] = {
  'installs'  => [ {
    'app_root' => '/var/www/apps/redtape/current',
    'run_service' => false
  } ]
}

include_recipe "unicorn"
