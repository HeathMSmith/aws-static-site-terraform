resource "aws_route53_record" "root_a" {
  count = var.enable_apex_redirect ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.redirect[0].domain_name
    zone_id                = aws_cloudfront_distribution.redirect[0].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "root_aaaa" {
  count = var.enable_apex_redirect ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.redirect[0].domain_name
    zone_id                = aws_cloudfront_distribution.redirect[0].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_a" {
  for_each = toset(var.dns_alias_names)

  zone_id = var.hosted_zone_id
  name    = each.value
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_aaaa" {
  for_each = toset(var.dns_alias_names)

  zone_id = var.hosted_zone_id
  name    = each.value
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_cloudfront_ownership" {
  zone_id = var.hosted_zone_id
  name    = "_www.hmsdev.click"
  type    = "TXT"
  ttl     = 60

  records = [
    "d3unb35rmr9g0x.cloudfront.net"
  ]
}