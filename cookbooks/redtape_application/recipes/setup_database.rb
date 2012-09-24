deploy_user = node['maintenance']['deploy_user']['name']
deploy_group = node['maintenance']['deploy_user']['group']

directory '/etc/databases' do
  user deploy_user
  group deploy_group
  mode '775'
  recursive true
end

template '/etc/databases/redtape.yml' do
  user deploy_user
  group deploy_group
  mode '775'
  source 'database.yml.erb'
  variables(node['redtape_application']['database'])
end

execute 'create_database' do
  command "mysql --user='#{node['redtape_application']['database']['username']}'
                 --password='#{node['redtape_application']['database']['password']}'
                 -e \"CREATE DATABASE IF NOT EXISTS #{node['redtape_application']['database']['database']}
                                                    DEFAULT CHARACTER SET utf8
                                                    COLLATE utf8_general_ci\"".gsub /\s+/, ' '
  user deploy_user
  group deploy_group
end
