
# Challenge 3 - Prisma

## Task 1
To automate the deployment, I made use of two technologies: **Terraform** and **Cloudformation**.

Below are the instructions on how to run the scripts.

## Deploy using Terraform

The Terraform script creates an s3 bucket for hosting static websites, it also provisions  CloudFront and uploads the website content to the s3 bucket after creation.

### Prerequisite
> The project uses Terraform v0.12.26
- Install [Terraform 0.12.x](https://www.terraform.io/downloads.html) if you don't already have it
- Install [AWS CLI](https://docs.aws.amazon.com/cli/index.html) if you don't already have it 
- Export your AWS credentials
```
export AWS_ACCESS_KEY_ID=                                   
export AWS_SECRET_ACCESS_KEY=                                        
export AWS_DEFAULT_REGION= 
```
Alternatively, you can  configure your AWS credentials using the AWS CLI. To do this,  run the command below and follow the prompt
```
aws configure
```

- cd into the project directory and run  the *deploy_with_terraform.sh* script
```
bash deploy_with_terraform.sh
```
- Wait for the deployment to complete then visit the website using the CloudFront domain URL

**To delete the resources, run `terraform destroy` inside the deployment/terraform folder**

## Deploy using Cloudformation
The CloudFormation script provisions a private s3 bucket with a bucket policy that allows access only through the CloudFront endpoint.

- Configure your AWS credentials using the AWS CLI. To do that, run the command below and follow the prompt
```
aws configure
```
- cd into the project directory and run  the *deploy_with_cloudformation.sh* script
```
bash deploy_with_cloudformation.sh
```
- Wait for the deployment to complete then visit the website using the cloudfront domain url


   **Note: The CloudFront distribution takes about 15 - 30 minutes to fully  propagate. If you get redirected to the s3 bucket URL when accessing the CloudFront URL  that means the CloudFront distribution is still propagating, give it some time and try again.**

## Task 2
I added a restriction to traffic from China and Hong Kong using CloudFront's Geo-Restriction feature.

> CloudFront Geo-Restriction using Terraform
```
restrictions {
    geo_restriction {
    restriction_type = "blacklist"
    locations = ["CN", "HK"]
  }
}
```


> CloudFront Geo-Restriction using CloudFormation
```
Restrictions:
	GeoRestriction:
		RestrictionType: blacklist
		Locations:
		- CN
		- HK
```
   
## Task 4
Below are some of the issues i noticed
- I noticed that the file extensions were not valid. 

```
example head.js was written as head.j_
```
- I also noticed that there was no script to generate the static files during deployment. I added the deploy script to package.json

```
"scripts": {
	"dev": "next",
	"build": "next build",
	"start": "next start",
	"deploy": "next build && next export"
}
```
- There was no .gitignore file to prevent commiting unwanted files and folders to the a repository.
- Also, putting the haveibeenpwned.com api URL in an env file would have been a better option

## Project directory
.
├── README.md
├── components
│   ├── breaches.js
│   ├── head.js
│   └── nav.js
├── deploy_with_cloudfromation.sh
├── deploy_with_terraform.sh
├── deployment
│   ├── cloudformation
│   │   └── s3bucket_with_cloudfront.yml
│   └── terraform
│       ├── main.tf
│       ├── modules
│       │   └── aws
│       │       ├── cloudfront
│       │       │   ├── main.tf
│       │       │   ├── output.tf
│       │       │   └── variables.tf
│       │       └── s3
│       │           ├── README.md
│       │           ├── main.tf
│       │           ├── output.tf
│       │           └── variables.tf
│       ├── output.tf
│       ├── variables.tf
│       └── versions.tf
├── next.config.js
├── package-lock.json
├── package.json
├── pages
│   └── index.js
└── static
    └── favicon.ico