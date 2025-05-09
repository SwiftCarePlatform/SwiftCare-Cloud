provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Define VPC
resource "aws_vpc" "swiftcare_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "swiftcare-vpc"
  }
}

# Define Subnet
resource "aws_subnet" "swiftcare_subnet" {
  vpc_id     = aws_vpc.swiftcare_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name = "swiftcare-subnet"
  }
}

# Define Internet Gateway
resource "aws_internet_gateway" "swiftcare_igw" {
  vpc_id = aws_vpc.swiftcare_vpc.id

  tags = {
    Name = "swiftcare-igw"
  }
}

# Define Route Table
resource "aws_route_table" "swiftcare_route_table" {
  vpc_id = aws_vpc.swiftcare_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swiftcare_igw.id
  }

  tags = {
    Name = "swiftcare-route-table"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "swiftcare_rta" {
  subnet_id      = aws_subnet.swiftcare_subnet.id
  route_table_id = aws_route_table.swiftcare_route_table.id
}

# Define Security Group
resource "aws_security_group" "swiftcare_sg" {
  name        = "swiftcare_sg"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.swiftcare_vpc.id  # Reference the VPC

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

# Define EC2 Instance
resource "aws_instance" "swiftcare_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.swiftcare_subnet.id  # Reference subnet
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.swiftcare_sg.id]
# user_data                   = file("user_data.sh")
  tags = {
    Name = "swiftcare-server"
  }
}

# Define S3 Bucket
resource "aws_s3_bucket" "swiftcare_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "swiftcare-s3"
    Environment = "Production"
  }
}
