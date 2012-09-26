name 'nginx'
description 'Installs and configures nginx reverse proxy'

default_attributes firewall: {
                     rules: [
                       { http: { port: '80'} },
                       { https: { port: '443'} }
                     ]
                   }

run_list 'recipe[nginx]'
