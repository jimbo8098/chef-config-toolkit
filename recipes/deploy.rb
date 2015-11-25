if node['deploy']['folders']
    node['deploy']['folders'].each do |folder, options|
        if options['chmod'].nil?
            options['chmod'] = "755"
        end

        directory folder do
          owner options.user
          group options.group
          mode options.chmod
          action :create
        end
    end
end

if node['deploy']['files']
    node['deploy']['files'].each do |file, options|
        if options['chmod'].nil?
            options['chmod'] = "755"
        end

        if options['content'].nil?
            options['content'] = ""
        end

        file file do
          owner options['user']
          group options['group']
          mode options['chmod']
          content options['content']
        end
    end
end
