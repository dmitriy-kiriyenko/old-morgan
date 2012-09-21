deploy_user  = node['maintenance']['deploy_user']['name']
deploy_group = node['maintenance']['deploy_user']['group']
database_params = node['redtape_application']['database']

node["unicorn"]["installs"] = [{ "app_root" => "/var/www/apps/redtape/current" }]
