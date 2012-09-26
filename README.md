# Chef Repository for Turbine Application

A list of cookbooks and recipes to set the things up for [Turbine RoR
application](https://github.com/mstibbe/Turbine-Application).

## Setup for a new developer

Ok, so there is a new developer in a project and we need to set the
things up. There are two things to be done:

1. A new user should be added to all servers.
2. A new chef-client should be created and configured.

These two tasks fit good together when done on a new developer's
machine.

So,

* Clone this repository:

```console
git clone git@github.com:mstibbe/Turbine-Chef.git
```

* Install required gems:

```console
bundle
```

* Download and install vendor cookbooks:

```console
bundle exec librarian-chef install
```

* Navigate to our Chef Server Web UI: http://articulateexpress.com:4040.
Login (as admin or somehow else). Existing developers should help you.
* Go to clients and create a client with admin privileges
* Copy private key to `.chef/client.pem`
* Run `./bin/knife client list` from the repository root - you should see clients list
* Copy `/etc/chef/validation.pem` and place it to `.chef/validation.pem`
* Add your username and public key to `roles/base.rb`:

```ruby
admin_users: [
  { ... }, # one user
  { ... }, # another user
  {
    name: 'aratak',
    ssh_key: 'ssh-rsa BLAHBLAHBLAH= aratak@anahoret.com'
  }
]
```

* Add your public key to deploy user in `roles/base.rb`:

```ruby
deploy_user: {
  # name, group, etc...
  ssh_key: "ssh-rsa BLAHBLAHBLAH= aratak@anahoret.com
ssh-rsa BLAHBLAHBLAH2= dak@anahoret.com"
}
```

* Try running chef-client. This will add the new developer to all
  servers.

```console
rake deploy:all
```

* Explore contents of Rakefile to find out other deployment jobs.

## Bootstrapping a new node (production or staging)

TODO: this section pending.

## Cookbooks

### librarian-chef

The project uses [`librarian-chef`](https://github.com/applicationsonline/librarian) to manage cookbooks. To install cookbooks run:

```bash
bundle exec librarian-chef install
```

Upload cookbooks to chef server

```bash
rake deploy:cookbooks
```

*Hint: a good place to start searching for a cookbook is an official Opscode repository - [https://github.com/opscode-cookbooks](https://github.com/opscode-cookbooks)*

### Managing custom cookbooks

The `vendor-cookbooks` directory in your repository is used **only** for cookbooks managed by librarian. This directory is ignored by git and it's really bad idea to change anything inside this directory. To manage your custom cookbooks you should place them into `cookbooks` directory and put them under the version control.

`knife` is setup automatically to look for your cookbooks in both directories. The `cookbooks` directory has higher priority so when you'd run `bin/knife cookbook create foo` cookbook would be created in this directory.

## Roles

Roles are building blocks of your infrastructure. Try to keep them small, concise, and reusable.

### Creating a new role

The easiest way to create a new role is to take any of the bundled roles and use the same structure. To upload role to chef server use the following command:

```bash
rake deploy:roles
```

**Important note: - Every time you update your role you have to upload it to the server**

### Assigning a role to a node

```bash
bundle exec knife node run_list add nodename role[postfix]
```

## Bootstrapping a new node

Review and edit `Cheffile` and `roles/base.rb` - it is recommended to start with minimum setup (like installing one package) and then start adding new packages and make changes doing a small controllable (and reversible) steps.

```bash
./bin/knife role from file roles/base.rb
./bin/knife bootstrap 192.168.33.11 --ssh-user vagrant --distro ubuntu12.04-gems -r 'role[base]' --node-name "application" --sudo

```

See [`knife bootstrap` manual](http://wiki.opscode.com/display/chef/Knife+Bootstrap) for more information.

## Running chef-client remotely

If you're using the bundled `base` role there is a special user on your node `deploy` which is allowed to run `chef-client` with sudo privileges. To run `chef-client` on nodes you can run the following command:

```bash
rake deploy:application
```

## Bootstrapping the new chef server (to move it to a new machine)

```console
./bin/knife bootstrap 192.168.33.11 --ssh-user root --distro server_ubuntu_1_9_3 --node-name "chef.turbinehq.com" --sudo
```

* `--distro` - bootstrap template (look for them in `.chef/bootstrap` folder)
* `--node-name` - this parameter controls hostname of chef server. It's a good idea to set the hostname to be the same as domain.

See [`knife bootstrap` manual](http://wiki.opscode.com/display/chef/Knife+Bootstrap) for more information.
