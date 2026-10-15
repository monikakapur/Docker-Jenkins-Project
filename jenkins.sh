#!/usr/bin/env bash
set -e

# STEP 1: Install Git and Maven
sudo apt update
sudo apt install -y git maven

# STEP 2: Install Java 21
sudo apt install -y fontconfig openjdk-21-jre
java -version

# STEP 3: Add Jenkins LTS repository
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# STEP 4: Install Jenkins
sudo apt update
sudo apt install -y jenkins

# STEP 5: Start Jenkins using systemctl
sudo service jenkins start
sudo service jenkins status

# Show the initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword