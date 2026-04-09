terraform {
  backend "s3" {
    bucket         = "hms-tfstate-static-site"
    key            = "static-site/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}