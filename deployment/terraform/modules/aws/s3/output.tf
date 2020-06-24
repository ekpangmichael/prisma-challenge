

output "website_endpoint" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.b.website_endpoint
}

output "bucket_regional_domain_name" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.b.bucket_regional_domain_name
}