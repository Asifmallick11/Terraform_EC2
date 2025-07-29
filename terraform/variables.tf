variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string  
}

variable "access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
}

variable "public_key" {
  description = "This is the Public Key for EC2"
  type = string
}

variable "vpc_id" {
  description = "The Associated VPC"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
}


variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
}

variable "private_key" {
  description = "Private key to shh into ec2"
  type        = string
}



