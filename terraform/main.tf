
provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "swiftcare_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  availability_zone           = "eu-north-1a"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.swiftcare_sg.id]
  user_data                   = file("user_data.sh")
  tags = {
    Name = "swiftcare-server"
  }
}

resource "aws_security_group" "swiftcare_sg" {
  name        = "swiftcare_sg"
  description = "Allow web traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
}

resource "aws_s3_bucket" "swiftcare_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "swiftcare-s3"
    Environment = "Production"
  }
}
