resource "aws_route53_zone" "site" {
  name = "hmsdev.click"

  tags = {
    Project     = "aws-static-site-terraform"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route53_record" "migration_root_a" {
  zone_id = aws_route53_zone.site.zone_id
  name    = "hmsdev.click"
  type    = "A"

  alias {
    name                   = "d3bc8xw8h6tjpo.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "migration_root_aaaa" {
  zone_id = aws_route53_zone.site.zone_id
  name    = "hmsdev.click"
  type    = "AAAA"

  alias {
    name                   = "d3bc8xw8h6tjpo.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "migration_www_a" {
  zone_id = aws_route53_zone.site.zone_id
  name    = "www.hmsdev.click"
  type    = "A"

  alias {
    name                   = "d3d77k7hvj1ch.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "migration_www_aaaa" {
  zone_id = aws_route53_zone.site.zone_id
  name    = "www.hmsdev.click"
  type    = "AAAA"

  alias {
    name                   = "d3d77k7hvj1ch.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

locals {
  legacy_acm_validation_records = {
    root_1 = {
      name  = "_2e4b1bcfcbda74307b569ea2a87a8505.hmsdev.click"
      value = "_4eb94d24652563a6ae4d6993df3d2c39.jkddzztszm.acm-validations.aws"
      ttl   = 500
    }

    root_2 = {
      name  = "_68e709b925a6862a86639c4888f8e8c2.hmsdev.click"
      value = "_7362b028756e25c990d73570bc10bb4c.jkddzztszm.acm-validations.aws"
      ttl   = 60
    }

    www = {
      name  = "_0abb96d89ed6e6dd487110f9fb4c822b.www.hmsdev.click"
      value = "_b684bab8cbef36a3d080fc1bebf04a52.jkddzztszm.acm-validations.aws"
      ttl   = 60
    }
  }
}

resource "aws_route53_record" "legacy_acm_validation" {
  for_each = local.legacy_acm_validation_records

  zone_id = aws_route53_zone.site.zone_id
  name    = each.value.name
  type    = "CNAME"
  ttl     = each.value.ttl
  records = [each.value.value]
}