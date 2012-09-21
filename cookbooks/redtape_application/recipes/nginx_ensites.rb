nginx_site 'default' do
  enable false
end

template '/etc/nginx/sites-available/redtape_application' do
  source 'redtape_application.conf.erb'
  mode '644'
end

nginx_site 'redtape_application' do
  enable true
end
