FROM ruby:2.4.2
LABEL maintainer="Marcelo G Silva <mgswolf@gmail.com>"

# RUN apk update && apk add build-base nodejs mysql-client mysql-dev
RUN apt-get update && apt-get install build-essential nodejs mysql-client libmysqld-dev libpq-dev postgresql-client -y 

RUN mkdir /app
WORKDIR /app/task-manager-api
# ENV HOME=/app/task-manager-api PATH=/app/task-manager-api/bin

COPY ./task-manager-api /app/

ADD ./task-manager-api/Gemfile /app/task-manager-api/Gemfile
# ADD ./task-manager-api/Gemfile.lock /app/task-manager-api/Gemfile.lock

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
# Add bundle entry point to handle bundle cache

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
# Bundle installs with binstubs to our custom /bundle/bin volume path.
# Let system use those stubs
