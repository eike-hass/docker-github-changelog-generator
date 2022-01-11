# based on https://github.com/github-changelog-generator/docker-github-changelog-generator/blob/master/Dockerfile

FROM ruby:2.7.3-alpine3.13

LABEL maintainer="eike-hass@web.de"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

RUN apk add --no-cache \
  git=2.30.2-r0

WORKDIR /
COPY Gemfile Gemfile
COPY entrypoint.sh entrypoint.sh
RUN apk add --no-cache \
  linux-headers \
  --virtual .gem-installdeps \
  build-base=0.5-r2 \
  && gem install bundler --version 2.2.15 \
  && bundle config set --local system 'true' \
  && bundle install 

ENV SRC_PATH /usr/local/src/your-app
RUN mkdir -p "${SRC_PATH}"

VOLUME [ "$SRC_PATH" ]
WORKDIR $SRC_PATH

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
