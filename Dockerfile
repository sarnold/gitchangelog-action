FROM ubuntu:20.04

LABEL "maintainer"="Stephen Arnold <nerdboy@gentoo.org>" \
      "repository"="https://github.com/sarnold/gitchangelog-action" \
      "homepage"="https://github.com/sarnold/gitchangelog-action" \
      "com.github.actions.name"="gitchangelog-action" \
      "com.github.actions.description"="Run gitchangelog as github action" \
      "com.github.actions.icon"="check-circle" \
      "com.github.actions.color"="package"

ENV DEBIAN_FRONTEND noninteractive
# Set PYTHONUNBUFFERED so we don't get interleaved output
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /tmp/* && \
    python3 -m pip install https://github.com/sarnold/gitchangelog/archive/3.0.5.tar.gz

ADD ./genchangelog.sh /genchangelog.sh

ENTRYPOINT ["/genchangelog.sh"]
