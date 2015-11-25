if node['deploy']['folders']
    node['deploy']['folders'].each do |folder, options|
        @chmod = "755"

        if options.chmod
            @chmod = options.chmod
        end

        directory folder do
          owner options.user
          group options.group
          mode @chmod
          action :create
        end
    end
end

if node['deploy']['files']
    node['deploy']['files'].each do |file, options|
        @chmod = "755"
        @content = ""

        if options.chmod
            @chmod = options.chmod
        end

        if options.content
            @content = options.content
        end

        file file do
          owner options.user
          group options.group
          mode @chmod
          content @content
        end
    end
end
