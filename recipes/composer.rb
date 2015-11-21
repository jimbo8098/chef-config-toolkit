execute "Composer Install" do
  command "curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer"
  action :run
  not_if { File.exist?("/usr/local/bin/composer") }
end

execute "Composer Update" do
  command "composer self-update"
  action :run
  not_if { node['composer']['key'] == false }
end

execute "Add Deployment Key" do
  command "composer config github-oauth.github.com --global \"#{node['composer']['key']}\""
  action :run
  not_if { node['composer']['key'] == nil }
end
