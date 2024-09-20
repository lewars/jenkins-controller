# syntax=docker/dockerfile:1

ARG BASE_IMAGE

FROM ${BASE_IMAGE}

ARG BASE_IMAGE

LABEL org.opencontainers.image.description="Custom Jenkins image with pre-installed plugins"
LABEL org.opencontainers.image.authors="Alistair Y. Lewars <alistair.lewars@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/lewars/jenkins-controller"

USER jenkins
WORKDIR  $JENKINS_HOME

COPY --chown=jenkins:jenkins scripts ./scripts
COPY --chown=jenkins:jenkins plugins.txt .

RUN echo "DEBUG: list script files" && \
    ls -l scripts
RUN ./scripts/install_jenkins_plugins.sh && \
    mkdir -p plugins && \
    chown jenkins:jenkins plugins && \
    cp plugins.txt plugins/ && \
    cp plugins-installed.txt plugins/

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/usr/local/bin/jenkins.sh"]
