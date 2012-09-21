node["unicorn"]["installs"] = [{ "app_root" => "/var/www/apps/redtape/current" }]
node["unicorn"]["config"] = {
  "path" => "/etc/unicorn/#{node["redtape_application"]["name"]}_config.rb"
}

directory "/etc/unicorn" do
  owner "deploy"
  group "deploy"
  group 700
  recursive true
end

include_recipe "unicorn"
