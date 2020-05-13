ARG NODE_IMAGE_TAG="11-alpine"
ARG KIBANA_IMAGE_TAG="6.6.2"

FROM node:${NODE_IMAGE_TAG} AS npm-build

ARG BOWER_VERSION="1.8.8"
ARG KIBANA_IMAGE_TAG

COPY modules/ /modules/

WORKDIR /modules/kibana-time-plugin

RUN npm install -g bower@${BOWER_VERSION} && \
	bower --allow-root install && \
	npm --no-git-tag-version version ${KIBANA_IMAGE_TAG}

FROM docker.elastic.co/kibana/kibana:${KIBANA_IMAGE_TAG}

ARG SEARCH_GUARD_URL="https://releases.floragunn.com/search-guard-kibana-plugin-6/6.6.2-19.0/search-guard-kibana-plugin-6-6.6.2-19.0.zip"
ARG LOGTRAIL_URL="https://github.com/sivasamyk/logtrail/releases/download/v0.1.31/logtrail-6.6.2-0.1.31.zip"

LABEL maintainer="info@redmic.es"

RUN ./bin/kibana-plugin install ${SEARCH_GUARD_URL}

RUN ./bin/kibana-plugin install ${LOGTRAIL_URL}

COPY --from=npm-build /modules/ plugins/
