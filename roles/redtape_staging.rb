name 'redtape_application'
description 'Manages deployment of Redtape Ruby on Rails application'

run_list 'role[base]',
         'role[ntp]',
         'role[chef-server]',
         'role[mysql-server]',
         'role[nginx]',
         'role[postfix]',
         'role[nodejs]',
         'role[git]',
         'recipe[redtape_application]'
