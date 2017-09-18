terraform {
  backend "s3" {
    bucket = "shared-tform-state"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "shared-tform-state"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}
