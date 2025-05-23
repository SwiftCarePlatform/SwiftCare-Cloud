output "instance_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.swiftcare_instance.public_ip
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.swiftcare_bucket.bucket
}
