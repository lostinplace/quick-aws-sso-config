#!/bin/bash

aws_tool=$(which aws)

if [ -z $aws_tool ]
then
  # install aws-cli v2
  mkdir -p ~/Downloads && cd $_
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install
fi

mkdir -p ~/.bin && cd $_
curl "https://gist.githubusercontent.com/chris-at-covariance/b449803ef201d9bd5256c23677f00629/raw/529a4973d86f118eb164b9193b683f81eaf3caeb/aws-sso-credential-process.sh" \
    -o "aws-sso-credential-process.sh"
chmod +x aws-sso-credential-process.sh

credential_process_path=$(realpath aws-sso-credential-process.sh)

aws configure set credential_process $credential_process_path
aws configure set sso_start_url https://covariancelabs.awsapps.com/start
aws configure set sso_region us-east-1
aws configure set sso_account_id 954116171219
aws configure set sso_role_name CovarianceTechTeam

aws sso login#!/bin/bash

aws_tool=$(which aws)

if [ -z $aws_tool ]
then
  # install aws-cli v2
  mkdir -p ~/Downloads && cd $_
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install
fi

mkdir -p ~/.bin && cd $_
curl "https://gist.githubusercontent.com/chris-at-covariance/b449803ef201d9bd5256c23677f00629/raw/529a4973d86f118eb164b9193b683f81eaf3caeb/aws-sso-credential-process.sh" \
    -o "aws-sso-credential-process.sh"
chmod +x aws-sso-credential-process.sh

credential_process_path=$(realpath aws-sso-credential-process.sh)

aws configure set credential_process $credential_process_path
aws configure set sso_region us-east-1

aws configure set sso_start_url https://d-9067a7676c.awsapps.com/start#/

aws configure sso

aws sso login