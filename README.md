# chef-config-toolkit
Config Toolkit Chef Cookbook


## Hosts
To append records into the `/etc/hosts` you can populate the attributes

```
{
    "hosts": {
        "127.0.0.1": [
            "localhost",
            "local",
            "example.com"
        ]
    }
}
```
