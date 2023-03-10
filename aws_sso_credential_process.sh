#!/bin/bash

# This script generates output for process_credentials from a user authenticated via SSO
# Before using, make sure that the AWS SSO is configured in your CLI: `aws configure sso`
# Usage: aws-sso-credential-process [AWS_PROFILE_NAME]

if [ $# -gt 0 ]; then
  AWS_PROFILE="$1"
fi

profile=${AWS_PROFILE-default}
temp_identity=$(aws --profile "$profile" sts get-caller-identity)
account_id=$(echo $temp_identity | jq -r .Arn | cut -d: -f5)
assumed_role_name=$(echo $temp_identity | jq -r .Arn | cut -d/ -f2)
session_name=$(echo $temp_identity | jq -r .Arn | cut -d/ -f3)
sso_region=$(aws --profile "$profile" configure get sso_region)

if [[ $sso_region == 'us-east-1' ]]; then
  sso_region_string=''
else
  sso_region_string="${sso_region}/"
fi
role_arn="arn:aws:iam::${account_id}:role/aws-reserved/sso.amazonaws.com/${sso_region_string}${assumed_role_name}"


request_credentials() {
  credentials=$(
    aws sts assume-role \
      --profile $profile \
      --role-arn $role_arn \
      --role-session-name $session_name | jq '.Credentials + {Version: 1}'
  )
}

request_credentials

if [ $? -ne 0 ]; then
  aws sso login --profile "$profile"

  if [ $? -ne 0 ]; then
    exit 1
  fi

  request_credentials
fi

echo $credentials

exit 0