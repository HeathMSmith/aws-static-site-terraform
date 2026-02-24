#########################################
# Core Infrastructure Settings
#########################################

variable "region" {
  description = "AWS region for primary resources (S3, etc.)"
  type        = string
  default     = "us-east-1"
}

variable "site_bucket_name" {
  description = "Globally unique S3 bucket name for static site"
  type        = string
  default     = "portfolio-static-hms"
}

#########################################
# Domain Configuration
#########################################

variable "domain_name" {
  description = "Primary domain name (e.g., hmsdev.click)"
  type        = string
  default     = "hmsdev.click"
}

variable "alternate_domain_names" {
  description = "Additional domain names (e.g., www subdomain)"
  type        = list(string)
  default     = ["www.hmsdev.click"]
}

variable "hosted_zone_id" {
  description = "Route 53 Hosted Zone ID for the domain"
  type        = string
  default     = "Z01454722VUNO8SQZYLZ8"
}

#########################################
# Tagging
#########################################

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Project = "aws-static-site-terraform"
    Domain  = "hmsdev.click"
    Owner   = "HeathMSmith"
  }
}