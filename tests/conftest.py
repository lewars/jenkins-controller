# conftest.py
import pytest
import testinfra

CONTAINER_NAME = "my-jenkins"
CONTROLLER_SOCKET = 'tcp://0.0.0.0:8080'
AGENT_SOCKET = 'tcp://0.0.0.0:50000'

@pytest.fixture(scope="module")
def required_jenkins_plugins():
    """Fixture that provides the list of Jenkins plugins to test"""
    return [
        "kubernetes",
        "docker-commons",
        "docker-commons",
        "docker-workflow",
        "git-client",
        "git",
        "kubernetes-client-api",
        "kubernetes-credentials",
        "kubernetes",
    ]

@pytest.fixture(scope="module")
def jenkins_container(host):
    """Fixture that provides the Jenkins container"""
    yield testinfra.get_host("docker://" + CONTAINER_NAME)
