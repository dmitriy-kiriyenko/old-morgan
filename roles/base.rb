name 'base'
description 'Base role applied to all nodes.'

default_attributes maintenance: {
                     deploy_user: {
                       name: 'deploy',
                       group: 'deploy',
                       ssh_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA+AwyvE4+LKS/0jU3abhD4Hpiu9pYTOeJjIPX5r2pOC/mh6I5zkFsrVZDfmZgKJwzRc4Vpj9W5dwvk8tArgNlQ7pXff+SAdTeE9piTn+9j+jhaBYzHKNlBXFRGT0o3huj2YA+SAIPGm5+egW0tBP2QyMQxjhP5EvUO8lkHvoYsjM= /Users/dak/.ssh/identity'
                     },
                     admin_users: [
                       {
                         name: 'dak',
                         ssh_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA+AwyvE4+LKS/0jU3abhD4Hpiu9pYTOeJjIPX5r2pOC/mh6I5zkFsrVZDfmZgKJwzRc4Vpj9W5dwvk8tArgNlQ7pXff+SAdTeE9piTn+9j+jhaBYzHKNlBXFRGT0o3huj2YA+SAIPGm5+egW0tBP2QyMQxjhP5EvUO8lkHvoYsjM= /Users/dak/.ssh/identity'
                       }
                     ]
                   }

run_list 'recipe[ufw]', 'recipe[maintenance]'
