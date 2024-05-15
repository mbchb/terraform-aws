/*
terraform {
  backend "s3" {
    region           = "{{ AWS_REGION }}"
    bucket           = "lz-terraform-state-{{ DEPLOYMENT_ACCOUNT_ID }}-{{ AWS_REGION }}"
    key              = "{{ REPOSITORY_NAME }}/{{ BRANCH_NAME }}/terraform.tfstate"
    dynamodb_table   = "lz-terraform-state-lock-table"
    encrypt          = "true"
    role_arn         = "arn:aws:iam::{{ DEPLOYMENT_ACCOUNT_ID }}:role/landing-zone/{{ REPOSITORY_PREFIX }}/lz-terraform-backend-{{ AWS_REGION }}-role"
    session_name     = "terraform-backend-{{ BRANCH_NAME }}"
    assume_role_tags = { "app:repository" = "{{ REPOSITORY_NAME }}" }
  }
  backend "s3" {
    bucket         = "mrcloudbook-cicd-bucket"
    key            = "my-terraform-environment/main"
    region         = "ap-south-1"
    dynamodb_table = "mrcloudbook-dynamo-db-table"
  }

    backend "s3" {
    bucket = "ratmdatastore" # Replace with your actual S3 bucket name
    key    = "Jenkins/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
*/
