# Attributes
app_root = '/var/www/apps/redtape/current'

node['unicorn'] = {
  'installs'  => [ { 'app_root' => app_root } ],

  'config_directory' =>  '/etc/unicorn',
  'config' => {
    'path' => "#{node['unicorn']['config_directory']}/#{node['redtape_application']['name']}_config.rb",
    'working_directory' => app_root,
    'listen' => [['8080', '{ :tcp_nodelay => true, :tries => 5 }']],
    'worker_processes' => [node['cpu']['total'].to_i * 4, 8].min
  },

  'service' => "unicorn-#{node['redtape_application']['name']}-#{node['unicorn']['rack_env']}",
  'command' => "cd #{node['unicorn']['app_root']} && bundle exec unicorn -D -E #{node['unicorn']['rack_env']} -c #{node['unicorn']['config']['path']}",
  'run_service' => false
}

# Actions
directory node['unicorn']['config_directory'] do
  owner "deploy" # these attributes should be taken
  group "deploy" # from 'maintenance/attributes/default.rb'
  group 700
  recursive true
end

include_recipe "unicorn"
