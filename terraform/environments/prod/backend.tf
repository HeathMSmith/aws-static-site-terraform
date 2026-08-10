terraform {
  backend "s3" {
    bucket       = "hms-terraform-state-portfolio"
    key          = "static-site/prod/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}