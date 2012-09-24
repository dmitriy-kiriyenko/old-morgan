node['unicorn'] = {
  'installs'  => [ {
    'app_root' => '/var/www/apps/redtape/current',
    'run_service' => false,
    'user' => 'deploy', # These variables should be detected
    'group' => 'deploy' # from maintenance/users.rb
  } ]
}

include_recipe "unicorn"
