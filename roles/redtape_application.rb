name 'redtape_application'
description 'Manages deployment of Redtape Ruby on Rails application'

default_attributes copycopter: {
                     environment: 'production',
                   }

run_list 'role[base]',
         'role[ntp]',
         'role[chef-server]',
         'role[mysql-server]',
         'role[nginx]',
         'role[postfix]',
         'role[nodejs]',
         'recipe[redtape_application]'
