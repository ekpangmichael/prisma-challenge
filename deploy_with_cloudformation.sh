#!/usr/bin/env bash
set -euo pipefail

# terminal colours
blue=`tput setaf 4`
green=`tput setaf 2`
reset=`tput sgr0`


echoMessage() {
  echo  -e "${1}========================= ${2} ============================== ${reset} \n "
}

# Create cloudformation stack
deployCloudformationStack() {
  cd ./deployment/cloudformation
  echoMessage "${blue}" "Started deployment..."
  aws cloudformation create-stack --stack-name s3-cloudfront --template-body file://s3bucket_with_cloudfront.yml --region eu-west-2 
  echoMessage "${blue}" "please wait, deploying stack..."
  sleep 30
}

# Deploy the application to s3
uploadWebsiteFiles() {
  echoMessage "${blue}" "Uploading website files"
  cd ../../
  npm install
  npm run deploy
  aws s3 sync ./out/ s3://breach-report-2020.com
  echoMessage "${green}" "Complete, visit the CloudFront url to access the website"
}

start() {
  deployCloudformationStack
  uploadWebsiteFiles
}

start