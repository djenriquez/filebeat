#!/usr/local/bin/dumb-init /bin/sh

DEFAULT_FILEBEAT_CONFIG_DIR=/etc/filebeat
DEFAULT_FILEBEAT_CONFIG_FILE=filebeat.yml

: ${FILEBEAT_CONFIG_DIR:=$DEFAULT_FILEBEAT_CONFIG_DIR}
: ${FILEBEAT_CONFIG_FILE:=$DEFAULT_FILEBEAT_CONFIG_FILE}

if [ ! -d "$FILEBEAT_CONFIG_DIR" ]; then
  mkdir -p $FILEBEAT_CONFIG_DIR
fi

if [ -n "$FILEBEAT_LOCAL_CONFIG" ]; then
	echo "$FILEBEAT_LOCAL_CONFIG" > "$FILEBEAT_CONFIG_DIR/$FILEBEAT_CONFIG_FILE"
fi

if [[ "$1" == "" ]]; then
     exec filebeat -e -c $FILEBEAT_CONFIG_DIR/$FILEBEAT_CONFIG_FILE -d "publish"
else
    exec filebeat "$@"
fi