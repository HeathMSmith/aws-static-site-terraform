# Highly Available Static Website on AWS (Terraform)

A production-grade static website platform built on AWS using Terraform, designed with a strong emphasis on **security, scalability, and real-world infrastructure patterns**.

This project goes beyond basic static hosting by combining **modern frontend presentation** with **secure, multi-environment cloud architecture**.

---

## Architecture Overview

All traffic is routed through CloudFront, ensuring the S3 origin remains private and inaccessible from the public internet.

![Architecture](./assets/architecture/static-site-architecture.png)

### Key Design Principles

- **Private-by-default infrastructure**
- **Edge-first content delivery**
- **Strict HTTPS enforcement**
- **Environment isolation (dev / prod)**
- **Infrastructure as Code (Terraform-driven)**

---

## Key Design Decisions

### Why CloudFront in front of S3
CloudFront enforces HTTPS, reduces latency via edge caching, and prevents direct access to the S3 origin. This improves both performance and security.

### Why S3 is private (OAC)
The S3 bucket is not publicly accessible. CloudFront Origin Access Control (OAC) ensures only CloudFront can access the bucket, reducing attack surface.

### Why Terraform manages static assets
Static files are deployed using Terraform (`aws_s3_object`) to maintain a fully declarative deployment process, eliminating manual uploads and drift.

### Why multi-environment (dev / prod)
Separate environments allow safe iteration and testing in dev while maintaining a stable production environment. This reflects real-world deployment workflows.

### Why CloudFront invalidation is required
CloudFront caches content globally. Invalidation ensures updates propagate immediately after deployments and prevents stale content delivery.

---

## What This Project Demonstrates

- Secure static hosting using **private S3 + CloudFront (OAC)**
- Global content delivery via **AWS edge locations**
- HTTPS using **ACM-managed certificates**
- DNS routing with **Route 53 alias records**
- Multi-environment deployments (**dev / prod**)
- Static asset deployment fully managed via **Terraform**
- Handling of **CloudFront caching and invalidation**
- Production-quality frontend design and UX

---

## Core AWS Services

### Amazon S3
- Hosts static assets (HTML, CSS, JS, images)
- Public access fully blocked
- Access controlled via CloudFront OAC

### Amazon CloudFront
- Global CDN distribution
- HTTPS enforcement at the edge
- Origin Access Control (OAC) secures S3 origin
- Handles caching and performance optimization

### AWS Certificate Manager (ACM)
- TLS certificates for HTTPS
- Deployed in **us-east-1** (CloudFront requirement)

### Amazon Route 53
- Domain management and routing
- ALIAS records to CloudFront distributions

---

## Environment Strategy

This project supports **fully isolated environments** to enable safe development and production workflows.

### Environments

- **dev**
  - Rapid iteration and testing
  - Mirrors production architecture

- **prod**
  - Stable, production-ready deployment
  - Optimized for reliability and presentation

Each environment includes:
- Independent Terraform state
- Environment-specific resource naming
- Fully isolated infrastructure

---

## Project Structure

```
.
├── site/                      # Static frontend (HTML, CSS, JS)
│   └── assets/                # Images, badges, diagrams
├── terraform/
│   ├── modules/               # Reusable infrastructure modules
│   ├── environments/
│   │   ├── dev/
│   │   └── prod/
│   └── backend.tf             # Remote state configuration
```

---

## Static Asset Deployment (Terraform)

All site assets are deployed via Terraform using `aws_s3_object`.

```hcl
resource "aws_s3_object" "site_files" {
  for_each = { for file in local.site_files : file => file }

  bucket = aws_s3_bucket.site.id
  key    = each.value
  source = "${var.site_source_path}/${each.value}"

  source_hash = filemd5("${var.site_source_path}/${each.value}")
}
```

---

## CloudFront Caching & Invalidation

```bash
aws cloudfront create-invalidation \
  --distribution-id <DIST_ID> \
  --paths "/*"
```

---

## Security Design

- S3 bucket is **not publicly accessible**
- Access restricted via **CloudFront OAC**
- HTTPS enforced at the edge
- Direct S3 access explicitly denied via bucket policy

---

## Cost Optimization

- S3 storage: minimal cost
- CloudFront: free tier eligible
- Route 53: ~$0.50/month per hosted zone
- ACM: free

---

## Deployment

### Deploy to Dev

```bash
cd terraform/environments/dev
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

### Deploy to Prod

```bash
cd terraform/environments/prod
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

---

## Teardown (Destroy Infrastructure)

```bash
cd terraform/environments/dev
terraform destroy
```

```bash
cd terraform/environments/prod
terraform destroy
```

> Ensure no dependencies (e.g., S3 objects or CloudFront distributions) block deletion.

---

## Demo

![Demo](./assets/screenshots/static-site.demo.png)

---

## Live Demo

https://dev.hmsdev.click  
https://www.hmsdev.click

---

## Tech Stack

**AWS | Terraform | CloudFront | S3 | Route 53 | ACM**
