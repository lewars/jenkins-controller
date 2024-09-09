# syntax=docker/dockerfile:1

ARG BASE_IMAGE=jenkins/jenkins:2.452.2-lts-jdk17

FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.description="Custom Jenkins image with pre-installed plugins"
LABEL org.opencontainers.image.authors="Alistair Y. Lewars <alistair.lewars@gmail.com>"
LABEL org.opencontainers.image.source="https://github.com/lewars/jenkins-controller"

USER root

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d \
    -b /usr/local/bin

COPY scripts/setup-venv.sh /usr/local/bin/setup-venv.sh
RUN chmod +x /usr/local/bin/setup-venv.sh

USER jenkins
WORKDIR  $JENKINS_HOME

COPY --chown=jenkins:jenkins install_jenkins_plugins.sh .
COPY --chown=jenkins:jenkins plugins.txt .

RUN ./install_jenkins_plugins.sh && \
    mkdir -p plugins && \
    chown jenkins:jenkins plugins && \
    cp plugins.txt plugins/ && \
    cp plugins-installed.txt plugins/

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["/bin/bash", "-c", "if [ \"$SETUP_PYTHON_ENV\" = \"true\" ]; then /usr/local/bin/setup-venv.sh; fi && /usr/local/bin/jenkins.sh"]
