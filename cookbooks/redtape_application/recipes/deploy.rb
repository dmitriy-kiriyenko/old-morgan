deploy_user  = node['maintenance']['deploy_user']['name']
deploy_group = node['maintenance']['deploy_user']['group']
database_params = node['redtape_application']['database']

application 'redtape_application' do
  path '/var/www/apps/redtape'
  owner deploy_user
  group deploy_group

  before_deploy do
    package 'libxslt-dev'
    package 'libxml2-dev'
  end

  before_symlink do
    execute 'create_and_migrate_database' do
      command 'bundle exec rake db:create db:migrate --trace'
      user deploy_user
      group deploy_group
      cwd release_path
      environment ({'RAILS_ENV' => node['redtape_application']['environment']})
    end

    execute 'compile_assets' do
      command 'bundle exec rake assets:precompile --trace'
      user deploy_user
      group deploy_group
      cwd release_path
      environment ({'RAILS_ENV' => node['redtape_application']['environment']})
    end
  end

  repository 'git@github.com:mstibbe/Turbine-Application.git'
  revision node['redtape_application']['revision']

  rails do
    gems ['bundler']

    database do
      database_params.each do |key, value|
        send(key.to_sym, value)
      end
    end
  end

  unicorn do
    restart_command do
      service 'redtape_application' do
        action :restart
      end
    end
  end
end
