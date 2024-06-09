# Minecraft Server Setup Guide

## Requirements

### Tooling

- **Terraform**: Version 1.0.11 or later
- **AWS CLI**: Version 2.0 or later
- **AWS Account**: With appropriate permissions to create EC2 instances and security groups

## Broad Overview

1. **Infrastructure Provisioning**: Use Terraform to provision the necessary AWS resources, including security groups and an EC2 instance.
2. **Configuration**: A startup script (`minecraft.sh`) configures the EC2 instance, installs Java, downloads the Minecraft server, and sets up the server as a systemd service.
3. **Deployment**: Execute Terraform commands to initialize, format, validate, and apply the configuration, deploying the Minecraft server.

## Tutorial

### Step 1: Set Up Your Environment

1. **Clone Repository**: Clone this repository on to you local machine. 
2. **Install Terraform**: Follow the [official guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) to install Terraform.
3. **Install AWS CLI**: Follow the [official guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) to install AWS CLI.
4. **Configure AWS CLI**: Run `aws configure` and provide your AWS Access Key ID, Secret Access Key, region, and output format.
5. **Generate SSH Key**: Generate an SSH key named `MinecraftKey`  by going to the AWS dashboard, search for "key pairs" in the search bar, and click "Create key pair". Name it `MinecraftKey`, and download the `.pem` file into the cloned repository.
### Step 2: Run Start_Server.sh
1. Once you are ready run  the start_server.sh script
```sh 
./start_server.sh
```

2. This script will run Terraform commands, which will apply the configuration, and execute the remote-exec provisioner. Once the script is done it will print the public IP address for the server. You can then connect using your `nmap -sV -Pn -p T:25565 <instance_public_ip>` and enjoy your server.

### Step 3: Delete Server
1. Once you are done using the server run the command
```sh 
terraform destroy
```

2. Type yes to confirm the destruction of the server

## Sources

- https://www.youtube.com/watch?v=zL4Xt7CyuDE
- https://medium.com/@antoinecichowicz/minecraft-server-on-aws-ecs-fargate-using-terraform-6626932a75c5
- https://github.com/Yris-ops/minecraft-server-aws-ecs-fargate/blob/main/main.tf
- CS312 class material