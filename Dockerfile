FROM alpine

LABEL "maintainer"="Stephen Arnold <nerdboy@gentoo.org>" \
      "repository"="https://github.com/sarnold/gitchangelog-action" \
      "homepage"="https://github.com/sarnold/gitchangelog-action" \
      "com.github.actions.name"="gitchangelog-action" \
      "com.github.actions.description"="Run gitchangelog as github action" \
      "com.github.actions.icon"="check-circle" \
      "com.github.actions.color"="package"

RUN apk --no-cache add \
    python3 \
    python3-dev \
    bash \
    git \
    py3-pip

RUN pip install pystache>=0.6.0 --prefer-binary \
    -f https://github.com/sarnold/pystache/releases/

RUN pip install gitchangelog>=3.0.9 --prefer-binary \
    -f https://github.com/sarnold/gitchangelog/releases/

ADD ./gitchangelog-release.rc /gitchangelog-release.rc

ADD ./genchangelog.sh /genchangelog.sh

ENTRYPOINT ["/genchangelog.sh"]
