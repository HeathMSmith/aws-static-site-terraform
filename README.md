# Highly Available Static Website on AWS (Terraform)

A production-grade static website architecture deployed on AWS using Terraform, designed with **security, scalability, and multi-environment infrastructure practices**.

This project demonstrates real-world cloud architecture patterns including **private origins, CDN distribution, DNS integration, and environment-based infrastructure management**.

---

##  What This Project Demonstrates

- Secure static hosting using **private S3 + CloudFront**
- Global content delivery via **AWS edge locations**
- HTTPS with **ACM-managed certificates**
- DNS routing using **Route 53 alias records**
- **Multi-environment infrastructure (dev/prod)**
- Infrastructure as Code using **Terraform best practices**
- Environment isolation and reusable configuration patterns

---

##  Architecture Overview

User → Route 53 → CloudFront → S3 (private bucket)

![Architecture](./assets/architecture/S3%20Static%20Website.png)

### Core AWS Services

- **Amazon S3**
  - Hosts static assets
  - Public access fully blocked

- **Amazon CloudFront**
  - Global CDN distribution
  - HTTPS enforcement
  - Origin Access Control (OAC) for secure S3 access

- **AWS Certificate Manager (ACM)**
  - TLS certificate (must reside in us-east-1 for CloudFront)

- **Amazon Route 53**
  - Custom domain routing via ALIAS record

---

##  Environment Strategy

This project is structured to support **multiple isolated environments**, enabling safe development and production deployments.

### Environments

- **dev**
  - Used for testing and iteration
  - Lower-cost, rapid deployment cycles

- **prod**
  - Production-ready configuration
  - Stable and optimized for reliability

Each environment maintains:
- Separate Terraform state
- Independent resource naming
- Environment-specific variables

---

##  Project Structure

```
.
├── site/                      # Static frontend assets
├── terraform/
│   ├── modules/               # Reusable infrastructure modules
│   ├── environments/
│   │   ├── dev/
│   │   └── prod/
│   └── backend.tf             # Remote state configuration (optional)
```

---

##  Security Design

- S3 bucket is **not publicly accessible**
- Access restricted via **CloudFront Origin Access Control (OAC)**
- HTTPS enforced at the edge
- No direct origin exposure
- Environment isolation prevents cross-environment impact

---

##  Cost Optimization

- S3 storage: minimal cost
- CloudFront: free tier eligible for low traffic
- Route 53: ~$0.50/month per hosted zone
- ACM: free

---

##  Deployment

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

##  Key Learnings

- Implementing secure S3 origins using CloudFront OAC
- Managing DNS validation for ACM certificates
- Designing multi-environment Terraform architectures
- Structuring reusable infrastructure modules
- Separating state and configuration per environment
- Applying production-grade IaC workflows

---

##  Demo

_Add screenshot of deployed site here_

---

##  Future Enhancements

- CI/CD pipeline using GitHub Actions + OIDC
- Automated cache invalidation on deploy
- Custom error pages via CloudFront
- WAF integration for edge security
- Logging and monitoring (CloudFront + S3 access logs)

---

##  Live Demo

https://dev.hmsdev.click  
https://www.hmsdev.click

---

##  Tech Stack

**AWS | Terraform | CloudFront | S3 | Route 53 | ACM**
