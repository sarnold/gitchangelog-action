FROM python:3.9-alpine3.16

LABEL "maintainer"="Stephen Arnold <nerdboy@gentoo.org>" \
      "repository"="https://github.com/sarnold/gitchangelog-action" \
      "homepage"="https://github.com/sarnold/gitchangelog-action" \
      "com.github.actions.name"="gitchangelog-action" \
      "com.github.actions.description"="Run gitchangelog as github action" \
      "com.github.actions.icon"="check-circle" \
      "com.github.actions.color"="package"

RUN apk --no-cache add git bash

ADD genchangelog.sh /
ADD requirements.txt /
ADD gitchangelog-release.rc /

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r /requirements.txt
RUN chmod +x /genchangelog.sh

ENTRYPOINT ["/genchangelog.sh"]
