
output "domain_name" {
  description = "Cloudfront domain name"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}