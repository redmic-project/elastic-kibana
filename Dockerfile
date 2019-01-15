ARG PARENT_IMAGE_TAG="6.5.1"

FROM docker.elastic.co/kibana/kibana:${PARENT_IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ARG SEARCH_GUARD_URL="https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-kibana-plugin/6.5.1-17/search-guard-kibana-plugin-6.5.1-17.zip"

RUN ./bin/kibana-plugin install --no-optimize ${SEARCH_GUARD_URL}

ARG LOGTRAIL_URL="https://github.com/sivasamyk/logtrail/releases/download/v0.1.30/logtrail-6.5.1-0.1.30.zip"

RUN ./bin/kibana-plugin install --no-optimize ${LOGTRAIL_URL}
