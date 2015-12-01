if node['deploy']['folders']
    node['deploy']['folders'].each do |folder, options|
        chmod = "755"
        user = node['deploy']['user']
        group = node['deploy']['group']

        if options['chmod']
            chmod = options['chmod']
        end

        if options['group']
            group = options['group']
        end

        if options['user']
            user = options['user']
        end

        directory folder do
          owner "#{user}"
          group "#{group}"
          mode "#{chmod}"
          recursive true
          action :create
        end
    end
end

if node['deploy']['setfacl']
    node['deploy']['setfacl'].each do |folder, options|
        execute "setfacl #{folder}" do
          command "setfacl #{options} #{folder}"
          action :run
        end
    end
end

if node['deploy']['files']
    node['deploy']['files'].each do |file, options|
        chmod = "755"
        content = ""
        user = node['deploy']['user']
        group = node['deploy']['group']

        if options['chmod']
            chmod = options['chmod']
        end

        if options['content']
            content = options['content']
        end

        if options['group']
            group = options['group']
        end

        if options['user']
            user = options['user']
        end

        file file do
          owner "#{user}"
          group "#{group}"
          mode "#{chmod}"
          content "#{content}"
        end
    end
end
