FROM alpine

LABEL "repository"="http://github.com/tiacsys/git-rebase"
LABEL "homepage"="http://github.com/tiacsys/git-rebase"
LABEL "maintainer"="TiaC Systems <info@tiac-systems.net>"

RUN apk add --no-cache git openssh-client && \
  echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]
