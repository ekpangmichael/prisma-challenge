
##############################
 #     s3 and cloudfront    #
##############################
output "website_endpoint" {
  description = "Domain name of the bucket"
  value       = module.s3.website_endpoint
}

output "bucket_regional_domain_name" {
  description = "bucket regional domain name"
  value       = module.s3.bucket_regional_domain_name
}

output "cloudfront_domain_name" {
  description = "Cloudfront domain name"
  value       = module.cloudfront.domain_name
}
