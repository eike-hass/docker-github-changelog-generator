# based on https://github.com/github-changelog-generator/docker-github-changelog-generator/blob/master/Dockerfile

FROM ruby:3-alpine3.15

ENV REPO=https://github.com/github-changelog-generator/github-changelog-generator.git
ENV REF=594a9ccbf84a3172d05d35bb88a0998ed4a948a0
ENV SRC_PATH /usr/local/src/your-app

LABEL maintainer="eike-hass@web.de"

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

WORKDIR /

RUN apk add --no-cache \
  git \
  linux-headers \
  build-base \
  && gem install specific_install 

RUN gem specific_install -l ${REPO} -r ${REF}

RUN mkdir -p "${SRC_PATH}"

VOLUME [ "$SRC_PATH" ]
WORKDIR $SRC_PATH

ENTRYPOINT ["github_changelog_generator"]
CMD ["--help"]
