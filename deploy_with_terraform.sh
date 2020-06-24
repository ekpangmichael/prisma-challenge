#!/usr/bin/env bash
set -euo pipefail

# terminal colours
blue=`tput setaf 4`
green=`tput setaf 2`
reset=`tput sgr0`

echoMessage() {
  echo  -e "${1}========================= ${2} ============================== ${reset} \n "
}

# run the Terraform files
deploy() {
  cd ./deployment/terraform
  echoMessage "${blue}" "Started deployment..."
  echoMessage "${blue}" "Running terraform init"
  terraform init
  echoMessage "${blue}" "Running terraform apply"
  terraform apply --auto-approve
  echoMessage "${blue}" "Deployment complete. Visit the website using the CloudFront URL"
}

start() {
  deploy
}

start