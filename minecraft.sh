#!/bin/bash

# update default packages
sudo yum update -y

# get java 17
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install -y java-17-amazon-corretto-devel.x86_64

# download minecraft server
sudo curl -O https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar
# start the minecraft server to generate default files
java -Xmx1024M -Xms1024M -jar server.jar nogui


# accept minecraft eula
sudo echo "eula=true" > eula.txt

# create a systemd service file for minecraft server
sudo tee /etc/systemd/system/minecraft.service << EOT
[Unit]
Description=mc_server
After=network.target

[Service]
User=ec2-user
ExecStart=/usr/bin/java -Xmx1024M -Xms1024M -jar /home/ec2-user/server.jar nogui
ExecStop=stop
WorkingDirectory=/home/ec2-user
Restart=always

[Install]
WantedBy=multi-user.target
EOT



# enable the minecraft service
sudo systemctl enable minecraft.service
sudo systemctl start minecraft.service
