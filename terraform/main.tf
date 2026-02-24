locals {
  all_domains = distinct(concat([var.domain_name], var.alternate_domain_names))
}