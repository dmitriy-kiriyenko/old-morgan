default['redtape_application']['name'] = 'redtape'
default['redtape_application']['environment'] = 'production'

default['redtape_application']['database']['environment']  = node['redtape_application']['environment']
default['redtape_application']['database']['adapter']  = 'mysql2'
default['redtape_application']['database']['database'] = 'root'
default['redtape_application']['database']['host']     = 'localhost'
default['redtape_application']['database']['username'] = 'redtape'
default['redtape_application']['database']['password'] = node['mysql']['server_root_password']
