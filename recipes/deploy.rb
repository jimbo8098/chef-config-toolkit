if node['deploy']['folders']
    node['deploy']['folders'].each do |folder, options|
        @chmod = "755"

        unless options['chmod']
            @chmod = options['chmod']
        end

        directory folder do
          owner options.user
          group options.group
          mode @chmod
          action :create
        end
    end
end

