
output "instance_ip" {
  value = aws_instance.swiftcare_instance.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.swiftcare_bucket.bucket
}
