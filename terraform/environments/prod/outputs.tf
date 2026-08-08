output "hosted_zone_id" {
  description = "Route 53 hosted zone ID for hmsdev.click"
  value       = aws_route53_zone.site.zone_id
}

output "hosted_zone_name_servers" {
  description = "Authoritative Route 53 name servers for hmsdev.click"
  value       = aws_route53_zone.site.name_servers
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID for the prod static site"
  value       = module.static_site.cloudfront_distribution_id
}
