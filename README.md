# chef-config-toolkit
This toolkit has recipes for the following;

- Hosts
- Composer

## Hosts
To append records into the `/etc/hosts` you can populate the attributes

```
{
    "default_attributes": {
        "hosts": {
            "127.0.0.1": [
                "localhost",
                "local",
                "example.com"
            ]
        }
    },
    "run_list": [
        "recipe[config-toolkit::hosts]"
    ]
}
```

## Composer

```
{
    "default_attributes": {
        "composer": {
           "update": false,
           "key": {
                "users": ["my-deploy-user"],
                "token": "1234"
            }
        }
    },
    "run_list": [
        "recipe[config-toolkit::composer]"
    ]
}
```
