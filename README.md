# Highly Available Static Website on AWS (Terraform)

## Architecture
- Amazon S3 (private bucket)
- CloudFront with Origin Access Control
- AWS Certificate Manager (us-east-1)
- Route 53 Alias Record
- HTTPS enforced

## Design Goals
- Secure (no public S3 access)
- Globally distributed via CDN
- Infrastructure as Code
- Cost-optimized
- Production-ready security posture

## Deployment

```bash
terraform init
terraform plan
terraform apply

