# Highly Available Static Website on AWS (Terraform)

A production-grade static website architecture deployed on AWS using Terraform, designed with security, scalability, and cost-efficiency as first-class concerns.

This project demonstrates real-world cloud architecture patterns including private origins, CDN distribution, DNS integration, and automated infrastructure provisioning.

---

## What This Project Demonstrates

- Secure static hosting using **private S3 + CloudFront**
- Global content delivery via **AWS edge locations**
- HTTPS with **ACM-managed certificates**
- DNS routing using **Route 53 alias records**
- Infrastructure as Code using **Terraform best practices**

---

## Architecture Overview

User → Route 53 → CloudFront → S3 (private bucket)

### Components

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

## Security Design

- S3 bucket is **not publicly accessible**
- Access restricted via **CloudFront Origin Access Control**
- HTTPS enforced at the edge
- No direct origin exposure

---

## Cost Optimization

- S3 storage: minimal cost
- CloudFront: free tier eligible for low traffic
- Route 53: ~$0.50/month
- ACM: free

---

## ⚙️ Deployment

```bash
cd terraform

terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

---

## 📁 Project Structure

```
.
├── site/          # Static frontend assets
├── terraform/     # Infrastructure as Code
```

---

## 🧪 Key Learnings

- Implementing secure S3 origins using CloudFront OAC
- Managing DNS validation for ACM certificates
- Understanding CloudFront + Route 53 integration
- Structuring Terraform for maintainability

---

## 📸 Demo

_Add screenshot of deployed site here_
