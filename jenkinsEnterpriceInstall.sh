#!/bin/bash

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
    wget -q -O - https://downloads.cloudbees.com/cloudbees-core/traditional/operations-center/rolling/debian/cloudbees.com.key | sudo apt-key add -
    sh -c 'echo deb https://downloads.cloudbees.com/cloudbees-core/traditional/operations-center/rolling/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    apt-get -y update > /dev/null
    apt-get -y install cloudbees-core-oc > /dev/null

    log "Waiting for Jenkins master to start..."
    sleep 30
}

# Primary Install Tasks
install_java
install_jenkins
exit 0