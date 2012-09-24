default['redtape_application']['name'] = 'redtape'
default['redtape_application']['environment'] = 'production'
default['redtape_application']['deploy']['user'] = 'deploy'
default['redtape_application']['deploy']['group'] = 'deploy'

default['redtape_application']['database']['environment']  = node['redtape_application']['environment']
default['redtape_application']['database']['adapter']  = 'mysql2'
default['redtape_application']['database']['database'] = 'redtape'
default['redtape_application']['database']['host']     = 'localhost'
default['redtape_application']['database']['username'] = 'redtape'
default['redtape_application']['database']['password'] = node['mysql']['application_password']
