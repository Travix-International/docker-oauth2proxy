# travix/oauth2proxy

[![Stars](https://img.shields.io/docker/stars/travix/oauth2proxy.svg)](https://hub.docker.com/r/travix/oauth2proxy/)
[![Pulls](https://img.shields.io/docker/pulls/travix/oauth2proxy.svg)](https://hub.docker.com/r/travix/oauth2proxy/)
[![License](https://img.shields.io/github/license/Travix-International/docker-oauth2proxy.svg)](https://github.com/Travix-International/docker-oauth2proxy/blob/master/LICENSE)

> Docker implementation of [oauth2Proxy](https://github.com/bitly/oauth2_proxy)


## Environment variables

To setup authentication using

| Name                 | Description                                               | Default value               |
| -------------------- | ----------------------------------------------------------| --------------------------- |
| OAUTH2_PROXY_AUTH    | Space separated list of user:password                     |

## Usage

### Authenticate using Google

```sh
docker run -d \
    -p 80:80 \
    -p 443:443 \
    travix/oauth2proxy:latest \
      -client-id=gcloud-client-id.apps.googleusercontent.com \
      -client-secret=gcloud-client-secret \
      -cookie-secret=$(openssl rand -base64 32) \
      -upstream=https://backend-server:8081 \
      -email-domain=mydomain.com
```


### Authenticate against a given user/password list

```sh
docker run -d \
    -p 80:80 \
    -p 443:443 \
    -e "OAUTH2_PROXY_AUTH=user1:pass1 user2:pass2 user3:pass3" \
    travix/oauth2proxy:latest \
      -htpasswd-file=/etc/oauth2proxy-auth \
      -cookie-secret=$(openssl rand -base64 32) \
      -tls-cert=/etc/ssl/private/tls.crt \
      -tls-key=/etc/ssl/private/tls.key \
      -upstream=https://backend-server:8081

curl -u user1:pass1 http://localhost
```


## License

MIT © [Travix International](http://travix.com)
