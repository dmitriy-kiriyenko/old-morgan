name 'mysql-server'
description 'Sets up mysql server and client'

default_attributes mysql: {
    client: {
      packages: ["mysql-client", "libmysqlclient-dev","ruby-mysql"]
    }
  }

run_list 'recipe[mysql::client]', 'recipe[mysql::server]'
node.set_unless['mysql']['application_password'] = secure_password
