# travix/oauth2proxy

[![Stars](https://img.shields.io/docker/stars/travix/oauth2proxy.svg)](https://hub.docker.com/r/travix/oauth2proxy/)
[![Pulls](https://img.shields.io/docker/pulls/travix/oauth2proxy.svg)](https://hub.docker.com/r/travix/oauth2proxy/)
[![License](https://img.shields.io/github/license/Travix-International/docker-oauth2proxy.svg)](https://github.com/Travix-International/docker-oauth2proxy/blob/master/LICENSE)

> Docker implementation of [oauth2_proxy](https://github.com/bitly/oauth2_proxy)


## Environment variables

You can setup authentication against a list of username/password, these are created when the container is started.

| Name                 | Description                                               | Example value               |
| -------------------- | ----------------------------------------------------------| --------------------------- |
| OAUTH2_PROXY_AUTH    | Space separated list of user:password                     | user1:pass1 user2:pass2


## Usage

### Authenticate using Google

```sh
docker run -d \
    -p 4180:4180 \
    travix/oauth2proxy:latest \
      -client-id=gcloud-client-id.apps.googleusercontent.com \
      -client-secret=gcloud-client-secret \
      -cookie-secret=$(head -c 16 /dev/urandom | md5sum | head -c 32) \
      -upstream=https://backend-server:8081 \
      -email-domain=mydomain.com
```


### Authenticate against a given user/password list

```sh
# run backend
docker run -d \
    --name backend-server \
    nginx:alpine

# run auth2proxy with user/pass and fake google credentials
docker run -d \
    -p 8080:80 \
    -e "OAUTH2_PROXY_AUTH=user1:pass1 user2:pass2 user3:pass3" \
    --link backend-server \
    travix/oauth2proxy:latest \
      -client-id=gcloud-client-id.apps.googleusercontent.com \
      -client-secret=gcloud-client-secret \
      -htpasswd-file=/etc/oauth2proxy-auth \
      -cookie-secret=$(head -c 16 /dev/urandom | md5sum | head -c 32) \
      -upstream=http://backend-server

curl -u user1:pass1 http://localhost:8080
```


## License

MIT © [Travix International](http://travix.com)
