ARG PARENT_IMAGE_TAG="6.5.4"

FROM docker.elastic.co/kibana/kibana:${PARENT_IMAGE_TAG}

LABEL maintainer="info@redmic.es"

ARG SEARCH_GUARD_URL="https://search.maven.org/remotecontent?filepath=com/floragunn/search-guard-kibana-plugin/6.5.4-17/search-guard-kibana-plugin-6.5.4-17.zip"

RUN ./bin/kibana-plugin install --no-optimize ${SEARCH_GUARD_URL}

ARG LOGTRAIL_URL="https://github.com/sivasamyk/logtrail/releases/download/v0.1.30/logtrail-6.5.4-0.1.30.zip"

RUN ./bin/kibana-plugin install --no-optimize ${LOGTRAIL_URL}

ARG	KBN_POLAR_URL="https://github.com/dlumbrer/kbn_polar/releases/download/6.3.X-1/kbn_polar-6.tar.gz"

RUN ./bin/kibana-plugin install ${LOGTRAIL_URL}

RUN mkdir -p plugins\kbn_polar && \
	cd plugins\kbn_polar && \
	curl -L ${KBN_POLAR_URL} --output kbn_polar-6.tar.gz && \
	tar xfvz kbn_polar-6.tar.gz