#!/bin/bash

Jenkins_host=localhost
Jenkins_port=8888
Jenkins_URL=http://${Jenkins_host}:${Jenkins_port}
workDir=/opt/
cli_path=${workDir}/jenkins-cli.jar
password_file= 
username=viktor
# groovy_install_script=
#Log method to control/redirect log output
log()
{
    echo "$1"
}

# Install openjdk
install_java()
{
    log "Installing java (default-jdk)"
    apt-get -y update > /dev/null
    apt-get -y install default-jdk > /dev/null
    apt-get -y update > /dev/null
}

install_jenkins()
{
    log "Installing CloudBees Jenkins Operations Center"
    # wget -q -O - https://downloads.cloudbees.com/cloudbees-core/traditional/operations-center/rolling/debian/cloudbees.com.key | sudo apt-key add -
    wget -q -O - https://downloads.cloudbees.com/cloudbees-core/traditional/client-master/rolling/debian/cloudbees.com.key | sudo apt-key add -
    # sh -c 'echo deb https://downloads.cloudbees.com/cloudbees-core/traditional/operations-center/rolling/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    sh -c 'deb https://downloads.cloudbees.com/cloudbees-core/traditional/client-master/rolling/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    apt-get -y update > /dev/null
    # apt-get -y install cloudbees-core-oc > /dev/null
    apt-get -y install cloudbees-core-cm > /dev/null

    log "Waiting for Jenkins master to start..."
    sleep 30
}

git_clone()
{
    git clone https://gZt4fP3dbpoiPyQyviZe@git.epam.com/Viktor_Keleberda/jenkins_script.git ${workDir}
}


PluginInstall()
{
    wget ${Jenkins_URL}/jnlpJars/jenkins-cli.jar -O ${workDir}
    java -jar ${cli_path} -s http://localhost:8080 who-am-i --username ${username} --password-file ${password_file}
    for plugin in ${pluginList}; do
        java -jar ${cli_path} -s http://localhost:8080 install-plugin ${plugin}
    done
}

# Primary Install Tasks
install_java
install_jenkins
git_clone
PluginInstall
exit 0
