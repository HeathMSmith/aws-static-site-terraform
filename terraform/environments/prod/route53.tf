resource "aws_route53_zone" "site" {
  name = "hmsdev.click"

  tags = {
    Project     = "aws-static-site-terraform"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route53_record" "root_a" {
  zone_id = aws_route53_zone.site.zone_id
  name    = "hmsdev.click"
  type    = "A"

  alias {
    name                   = "dzko78sb9x1jm.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root_aaaa" {
  zone_id = aws_route53_zone.site.zone_id
  name    = "hmsdev.click"
  type    = "AAAA"

  alias {
    name                   = "dzko78sb9x1jm.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_a" {
  zone_id = aws_route53_zone.site.zone_id
  name    = "www.hmsdev.click"
  type    = "A"

  alias {
    name                   = "d3unb35rmr9g0x.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_aaaa" {
  zone_id = aws_route53_zone.site.zone_id
  name    = "www.hmsdev.click"
  type    = "AAAA"

  alias {
    name                   = "d3unb35rmr9g0x.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

moved {
  from = aws_route53_record.migration_root_a
  to   = aws_route53_record.root_a
}

moved {
  from = aws_route53_record.migration_root_aaaa
  to   = aws_route53_record.root_aaaa
}

moved {
  from = aws_route53_record.migration_www_a
  to   = aws_route53_record.www_a
}

moved {
  from = aws_route53_record.migration_www_aaaa
  to   = aws_route53_record.www_aaaa
}
