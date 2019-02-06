ARG NODE_IMAGE_TAG="11-alpine"
ARG KIBANA_IMAGE_TAG="6.5.4"

FROM node:${NODE_IMAGE_TAG} AS npm-build

COPY modules/ /modules/

WORKDIR /modules/kibana-datepicker-plugin

RUN npm --no-git-tag-version version ${KIBANA_IMAGE_TAG}

FROM docker.elastic.co/kibana/kibana:${KIBANA_IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ARG SEARCH_GUARD_URL="https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-kibana-plugin/6.5.4-17/search-guard-kibana-plugin-6.5.4-17.zip"

RUN ./bin/kibana-plugin install --no-optimize ${SEARCH_GUARD_URL}

ARG LOGTRAIL_URL="https://github.com/sivasamyk/logtrail/releases/download/v0.1.30/logtrail-6.5.4-0.1.30.zip"

RUN ./bin/kibana-plugin install --no-optimize ${LOGTRAIL_URL}

COPY --from=npm-build /modules/ plugins/
