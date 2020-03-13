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
                sensitive true
                action :run
            end

            execute "Grant usage for user #{name}" do
                command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"GRANT usage on *.* to #{name}@#{host} identified by '#{value['password']}';\""
                sensitive true
                action :run
            end

            execute "Grant access for user #{name}" do
                command "mysql -u root -p#{node['mysql']['server_root_password']} -e \"GRANT ALL privileges ON #{value['database']}.* to #{name}@#{host};\""
                sensitive true
                action :run
            end
        end
    end

    execute "Set up timezones" do
      command node['mysql'].key('server_root_password')? "mysql_tzinfo_to_sql /usr/share/zoneinfo/ | mysql -u root mysql -p#{node['mysql']['server_root_password']}" : "mysql_tzinfo_to_sql /usr/share/zoneinfo/ | mysql -u root mysql"
        sensitive true
        action :run
        only_if { File.exist?("/usr/bin/mysql_tzinfo_to_sql") }
    end
end
