# test_infra.py
import pytest
from conftest import CONTAINER_NAME, CONTROLLER_SOCKET, AGENT_SOCKET


def test_jenkins_container(host):
    """Test Jenkins controller is running"""
    assert host.docker(CONTAINER_NAME).is_running


def test_jenkins_port(host):
    """Test Jenkins controller port is up and listening"""
    assert host.socket(CONTROLLER_SOCKET).is_listening


def test_jenkins_agent_port(host):
    """Test Jenkins agent port is up and listening"""
    assert host.socket(AGENT_SOCKET).is_listening


def test_jenkins_version(jenkins_container):
    """Test Jenkins version"""
    cmd = jenkins_container.run("java -jar /usr/share/jenkins/jenkins.war --version")
    assert cmd.rc == 0
    assert "2.462.2" in cmd.stdout


@pytest.mark.parametrize(
    "plugin",
    [
        "kubernetes",
        "docker-commons",
        "docker-workflow",
        "git-client",
        "git",
        "kubernetes-client-api",
        "kubernetes-credentials",
        "kubernetes",
    ],
)
def test_jenkins_plugins(jenkins_container, plugin):
    """Test if the required Jenkins plugins are installed"""
    plugin_path = f"/var/jenkins_home/plugins/{plugin}.jpi"
    plugin_file = jenkins_container.file(plugin_path)

    assert plugin_file.exists, f"Plugin {plugin} is not installed at {plugin_path}"
    assert plugin_file.is_file, f"Plugin {plugin} at {plugin_path} is not a file"
