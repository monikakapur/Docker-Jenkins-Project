#!/usr/bin/env bash
set -e

#STEP 1: Initialize Docker Engine into a Swarm Manager Node
docker swarm init

# STEP 2: Install Git and Maven
sudo apt update
sudo apt install -y git maven

# STEP 3: Install Java 21
sudo apt install -y fontconfig openjdk-21-jre
java -version

# STEP 4: Add Jenkins LTS repository
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# STEP 5: Install Jenkins
sudo apt update
sudo apt install -y jenkins

# STEP 6: Start Jenkins using service
sudo service jenkins start
sudo service jenkins status

# STEP 7: Wait for the initial admin password file to be generated (timeout after 30 seconds)
echo "Waiting for Jenkins initialization..."
for i in {1..30}; do
    if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
        break
    fi
    sleep 1
done

# STEP 8: Show the initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# STEP 9: Check Docker socket ownership and permissions
echo "Checking Docker socket..."
ls -l /var/run/docker.sock

# STEP 10: Give Jenkins user permission to use Docker
sudo usermod -aG docker jenkins

# STEP 11: Restart Jenkins to apply the new group membership
sudo service jenkins restart

# STEP 12: Verify Docker access as the Jenkins user
sudo -u jenkins docker ps

echo "Docker Swarm init and Jenkins installation and Docker access setup completed and verified."
