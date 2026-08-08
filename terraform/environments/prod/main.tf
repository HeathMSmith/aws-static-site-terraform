module "static_site" {
  source = "../../modules/static-site"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  environment = "prod"

  domain_name            = "hmsdev.click"
  alternate_domain_names = ["www.hmsdev.click"]
  dns_alias_names        = []
  certificate_sans       = ["www.hmsdev.click"]
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

moved {
  from = module.static_site[0]
  to   = module.static_site
}
