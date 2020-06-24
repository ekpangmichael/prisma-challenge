# Terraform configuration

provider "aws" {
  region = var.region
}

# Terraform module to provision s3
module "s3" {
  source = "../terraform/modules/aws/s3/"
  bucket_name = var.bucket_name
}

# Terraform module to provision cloudfront
module "cloudfront" {
  source = "../terraform/modules/aws/cloudfront/"
  regional_domain_name = module.s3.bucket_regional_domain_name
  bucket_name = var.bucket_name
}



