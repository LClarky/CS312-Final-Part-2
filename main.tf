
provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "minecraft security group"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minecraft_sg"
  }
}

resource "aws_instance" "minecraft_server" {
  ami                    = "ami-0eb9d67c52f5c80e5"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
  key_name               = "MinecraftKey"

  tags = {
    Name = "mcserver"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("MinecraftKey.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    content     = file("minecraft.sh")
    destination = "/home/ec2-user/minecraft.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/minecraft.sh",
      "/home/ec2-user/minecraft.sh"
    ]
  }
}

output "instance_public_ip" {
  value       = aws_instance.minecraft_server.public_ip
  description = "Instance public address"
}