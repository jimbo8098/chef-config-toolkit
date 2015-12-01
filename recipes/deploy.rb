if node['deploy']['folders']
    node['deploy']['folders'].each do |folder, options|
        @chmod = "755"
        @user = node['deploy']['user']
        @group = node['deploy']['group']

        unless options['chmod'].nil?
            @chmod = options['chmod']
        end

        unless options['group'].nil?
            @group = options['group']
        end

        unless options['user'].nil?
            @user = options['user']
        end

        directory folder do
          owner @user
          group @group
          mode @chmod
          recursive true
          action :create
        end
    end
end

if node['deploy']['setfacl']
    node['deploy']['setfacl'].each do |folder, options|
        execute "setfacl #{options}" do
          command "setfacl #{options}"
          action :run
        end
    end
end

if node['deploy']['files']
    node['deploy']['files'].each do |file, options|
        @chmod = "755"
        @content = ""
        @user = node['deploy']['user']
        @group = node['deploy']['group']

        unless options['chmod'].nil?
            @chmod = options['chmod']
        end

        unless options['content'].nil?
            @content = options['content']
        end

        unless options['group'].nil?
            @group = options['group']
        end

        unless options['user'].nil?
            @user = options['user']
        end

        file file do
          owner @user
          group @group
          mode @chmod
          content @content
        end
    end
end
