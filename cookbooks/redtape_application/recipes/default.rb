include_recipe 'redtape_application::packages_for_gems'
include_recipe 'redtape_application::setup_unicorn'
include_recipe 'redtape_application::nginx_ensites'
include_recipe 'redtape_application::application_folders'
