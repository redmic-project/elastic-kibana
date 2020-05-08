ARG NODE_IMAGE_TAG="11-alpine"
ARG KIBANA_IMAGE_TAG="6.5.4"

FROM node:${NODE_IMAGE_TAG} AS npm-build

ARG KIBANA_IMAGE_TAG

COPY modules/ /modules/

WORKDIR /modules/kibana-time-plugin

RUN npm install -g bower && \
	bower --allow-root install && \
	npm --no-git-tag-version version ${KIBANA_IMAGE_TAG}

FROM docker.elastic.co/kibana/kibana:${KIBANA_IMAGE_TAG}

LABEL maintainer="info@redmic.es"

RUN ./bin/kibana-plugin install --no-optimize ${SEARCH_GUARD_URL}

RUN ./bin/kibana-plugin install --no-optimize ${LOGTRAIL_URL}

COPY --from=npm-build /modules/ plugins/
