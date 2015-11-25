default[:hosts] = {}

default[:composer] = {}

default[:composer][:key] = {}
default[:composer][:key][:token] = nil
default[:composer][:key][:users] = []

default[:composer][:update] = true

default[:mysql] = {}
default[:mysql][:users] = {}

default[:deploy] = {}
default[:deploy][:user] = "root"
default[:deploy][:group] = "root"
default[:deploy][:folders] = {}
default[:deploy][:files] = {}
