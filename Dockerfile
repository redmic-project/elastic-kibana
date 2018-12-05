ARG PARENT_IMAGE_TAG="6.5.0"

FROM docker.elastic.co/kibana/kibana:${PARENT_IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ARG LOGTRAIL_URL="https://github.com/sivasamyk/logtrail/releases/download/v0.1.30/logtrail-6.5.0-0.1.30.zip"

RUN ./bin/kibana-plugin install ${LOGTRAIL_URL}
