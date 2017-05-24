#!/bin/sh
#
# Create user for each OAUTH2_PROXY_AUTH="user1:pass1 user2:pass2"

touch /etc/oauth2proxy-auth

if [ "${OAUTH2_PROXY_AUTH}" != "" ]
then
  for auth in $OAUTH2_PROXY_AUTH
  do
    values=$(echo $auth | tr ":" "\n")
    user=$(echo "$values" | head -n1)
    pass=$(echo "$values" | tail -n1)
    htpasswd -sb /etc/oauth2proxy-auth $user $pass
  done
fi

oauth2_proxy -http-address :80 -https-address :443 "$@"
