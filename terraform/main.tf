provider "aws" {
  region = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  backend "s3" {
    bucket = "asif-tfstate" 
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2_key"
  public_key = var.public_key
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = var.instance_name
  }

   provisioner "remote-exec" {
    inline = [
      "sudo apt update" ,
      "curl https://get.docker.com | bash"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" 
      private_key = var.private_key
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "touch dynamic_inventory.ini"
  }

  depends_on = [aws_key_pair.ec2_key, aws_security_group.ec2_sg]
}

data "template_file" "inventory" {
  template = <<-EOT
    [ec2_instances]
    ${aws_instance.ec2_instance.public_ip}
    EOT
}

resource "local_file" "dynamic_inventory" {
  depends_on = [aws_instance.public_instance]

  filename = "dynamic_inventory.ini"
  content  = data.template_file.inventory.rendered

}