default['redtape_application']['environment'] = 'production'
default['redtape_application']['revision']    = 'slim-ruby19'

default['redtape_application']['database']['adapter']  = 'mysql2'
default['redtape_application']['database']['database'] = 'redtape'
default['redtape_application']['database']['host']     = 'localhost'
default['redtape_application']['database']['username'] = 'root'
default['redtape_application']['database']['password'] = node['mysql']['server_root_password']
