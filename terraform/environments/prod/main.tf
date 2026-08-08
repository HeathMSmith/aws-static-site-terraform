module "static_site" {
  count = var.deploy_static_site ? 1 : 0

  source = "../../modules/static-site"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }

  environment = "prod"

  domain_name            = "hmsdev.click"
  alternate_domain_names = ["www.hmsdev.click"]
  hosted_zone_id         = var.hosted_zone_id

  site_bucket_name = var.site_bucket_name
  site_source_path = "../../../site"

  tags = {
    Environment = "prod"
  }
}