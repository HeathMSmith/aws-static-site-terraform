module "static_site" {
  count = var.deploy_static_site ? 1 : 0

  source = "../../modules/static-site"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  environment = "prod"

  domain_name            = "hmsdev.click"
  alternate_domain_names = ["migration.hmsdev.click", "www.hmsdev.click"]
  dns_alias_names        = ["migration.hmsdev.click"]
  certificate_sans       = ["www.hmsdev.click", "migration.hmsdev.click"]
  hosted_zone_id         = aws_route53_zone.site.zone_id
  enable_apex_redirect   = true
  enable_apex_alias      = true
  enable_apex_dns        = false

  site_bucket_name = var.site_bucket_name
  site_source_path = "../../../site"

  tags = {
    Environment = "prod"
  }
}