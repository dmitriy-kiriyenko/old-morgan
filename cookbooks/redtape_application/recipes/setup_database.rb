node.set_unless['mysql']['application_password'] = secure_password

directory '/etc/databases' do
  user node['redtape_application']['deploy']['user']
  group node['redtape_application']['deploy']['group']
  mode '775'
  recursive true
end

template '/etc/databases/redtape.yml' do
  user node['redtape_application']['deploy']['user']
  group node['redtape_application']['deploy']['group']
  mode '775'
  source 'database.yml.erb'
  variables(
    node['redtape_application']['database'].merge password: node['mysql']['application_password']
  )
end