# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "global"
  region = "eu-west-1"
}
