# syntax=docker/dockerfile:1

ARG BASE_IMAGE=jenkins/jenkins:2.452.2-lts-jdk17

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.description="Custom Jenkins image with pre-installed plugins"

USER root

COPY --chmod=755 install_jenkins_plugins.sh /usr/local/bin/install_jenkins_plugins.sh
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt

USER jenkins

RUN chmod +x /usr/local/bin/install_jenkins_plugins.sh

RUN cp -r -p /usr/share/jenkins/ref/plugins/. /var/jenkins_home/plugins/.

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
