variable "aws_profile" {
  default = "SwiftCare_Deploy"
}

variable "region" {
  default = "eu-north-1"
}

variable "ami_id" {
  default = "ami-0dd574ef87b79ac6c"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "aws_access_key" {
  default = "aws_access_key_id"
}
variable "aws_secret_key" {
  default = "aws_secret_access_key"
}
variable "key_name" {
  default = "swiftcare2_keypair"
}
variable "dockerhub_username" {
  default = "DOCKER_HUB_USERNAME"
}
variable "dockerhub_secret" {
  default = "DOCKER_HUB_SECRET"
}

variable "bucket_name" {
  default = "swiftcare-app-storage-bucket-cloud"
}
