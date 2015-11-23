if node['mysql'] && node['mysql']['users'] && node['mysql']['server_root_password']
    node['mysql']['users'].each do |name, value|
        if value['password'] && value['database']
            execute "Ensure Database exists for user #{name}" do
                command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"CREATE DATABASE IF NOT EXISTS #{value['database']};\""
                action :run
            end

            execute "Grant usage for user #{name}" do
                command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"GRANT usage on *.* to #{name}@localhost identified by '#{value['password']}';\""
                action :run
            end

            execute "Grant access for user #{name}" do
                command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"GRANT ALL privileges ON #{value['database']}.* to #{name}@localhost;\""
                action :run
            end
        end
    end
end
