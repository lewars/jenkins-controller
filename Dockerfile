# syntax=docker/dockerfile:1

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG BASE_IMAGE

LABEL org.opencontainers.image.description="Custom Jenkins image with pre-installed plugins"
LABEL org.opencontainers.image.authors="Alistair Y. Lewars <alistair.lewars@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/lewars/jenkins-controller"

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y -qq && \
    apt-get install -y -qq --no-install-recommends \
    ca-certificates \
    uidmap \
    && rm -rf /var/lib/apt/lists/*

# install docker client
RUN curl -fsSL https://get.docker.com | sh

# Install task runner
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin/

USER jenkins
WORKDIR  $JENKINS_HOME

COPY --chown=jenkins:jenkins scripts ./scripts
COPY --chown=jenkins:jenkins plugins.txt .

RUN mkdir -p $JENKINS_HOME/init.groovy.d/ && \
    cp ./scripts/approve-scripts.groovy $JENKINS_HOME/init.groovy.d/

RUN ./scripts/install_jenkins_plugins.sh && \
    mkdir -p plugins && \
    chown jenkins:jenkins plugins && \
    cp plugins.txt plugins/ && \
    cp plugins-installed.txt plugins/

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/usr/local/bin/jenkins.sh"]
