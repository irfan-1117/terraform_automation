terraform {
  backend "s3" {
    bucket  = "thatisfordevpurpose1117"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}