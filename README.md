# Dockerized Filebeat
This repo produces a docker version of elastic.co's filebeat service, which differ from other images in that it allows configuration by environment variable.

You can either mount a a config to `$FILEBEAT_CONFIG_DIR/$FILEBEAT_CONFIG_FILE` OR pass a config into `$FILEBEAT_LOCAL_CONFIG`.

# To Run:
## Env config
```sh
docker run -d \
--name filebeat \
--net host \
-e FILEBEAT_LOCAL_CONFIG='
filebeat.prospectors:
- input_type: log
  paths:
    - /var/log/*.log
output.elasticsearch:
  hosts: ["192.168.1.42:9200"]' \
djenriquez/filebeat:v5.6.2
```

## Mounted config
```sh
docker run -d \
--name filebeat \
--net host \
-e FILEBEAT_CONFIG_DIR=/ \
-e FILEBEAT_CONFIG_FILE=myconfig.yml \
-v "/etc/myconfig.yml:/myconfig.yml" \
djenriquez/filebeat:v5.6.2
```
