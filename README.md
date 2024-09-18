# bitwise-jenkins-controller

A customized Jenkins controller image with pre-installed plugins, built using the jenkins-plugin-cli.

## Description

This project builds a custom Jenkins controller Docker image with a predefined set of plugins. It uses the `jenkins-plugin-cli` to install plugins listed in a `plugins.txt` file. The installation process is driven by a shell script, which is executed during the Docker image build process.

## Key Components

- `Dockerfile`: Defines the Docker image build process.
- `install_jenkins_plugins.sh`: Shell script that handles plugin installation.
- `plugins.txt`: List of Jenkins plugins to be installed.

## Getting Started

### Prerequisites

- Docker
- Git
- Task

### Building the Image

1. Clone the repository:
   ```
   git clone https://github.com/your-org/jenkins-controller.git
   cd jenkins-controller
   ```

2. Build the Jenkins Docker image with plugins:
   ```
   task build
   ```

3. Test the Jenkins Docker image with plugins:
   ```
   task start-jenkins
   task unit-test
   ```

4. When done stop and remove Jenkins container
   ```
   task stop-jenkins
   task clean-all
   ```

### Running the Jenkins Controller and Connecting to It

After using the `task start-jenkins` command, access the Jenkins Controller here `http://localhost:8080`.

### Viewing logs of the Jenkins Controller

While the Jenkins container is running, you can view its logs with `task view-jenkins-log`.

## Customization

### Adding or Removing Plugins

Edit the `plugins.txt` file to modify the list of plugins to be installed. Each plugin should be on a new line, optionally followed by a colon and the desired version.

Example:
```
git:latest
workflow-aggregator:2.6
matrix-auth:2.6.7
```

### Modifying the Installation Process

If you need to change how plugins are installed, edit the `install_jenkins_plugins.sh` script.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the GNU License - see the [GNU](https://www.gnu.org/licenses/gpl-3.0.en.html#license-text) file for details.
