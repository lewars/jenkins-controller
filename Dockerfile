# syntax=docker/dockerfile:1

ARG BASE_IMAGE=jenkins/jenkins:2.452.2-lts-jdk17

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.description="Custom Jenkins image with pre-installed plugins"
LABEL org.opencontainers.image.authors="Alistair Y. Lewars <alistair.lewars@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/lewars/jenkins-controller"

USER jenkins
WORKDIR /var/jenkins_home

COPY --chown=jenkins:jenkins install_jenkins_plugins.sh .
COPY --chown=jenkins:jenkins plugins.txt .

RUN ./install_jenkins_plugins.sh && \
    cp plugins.txt plugins/ && \
    cp plugins-installed.txt plugins/

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
