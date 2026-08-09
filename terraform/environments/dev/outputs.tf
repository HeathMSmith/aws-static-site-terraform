output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID for the dev static site"
  value       = module.static_site.cloudfront_distribution_id
}
