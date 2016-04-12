if node['mysql'] && node['mysql']['users'] && node['mysql']['server_root_password']
    node['mysql']['users'].each do |name, value|
        if value['host']
            host = value['host']
        else
            host = 'localhost'
        end
        
        if value['password'] && value['database']
            execute "Ensure Database exists for user #{name}" do
                command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"CREATE DATABASE IF NOT EXISTS #{value['database']};\""
                action :run
            end

            execute "Grant usage for user #{name}" do
                command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"GRANT usage on *.* to #{name}@#{host} identified by '#{value['password']}';\""
                action :run
            end

            execute "Grant access for user #{name}" do
                command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"GRANT ALL privileges ON #{value['database']}.* to #{name}@#{host};\""
                action :run
            end
        end
    end
end
