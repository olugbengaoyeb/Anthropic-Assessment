# Anthropic-Assessment

---

# DevOps Technical Exercises – Overview

## Introduction

This repository contains a collection of **DevOps and Platform Engineering exercises** demonstrating practical experience in **cloud infrastructure, CI/CD, Kubernetes, automation, reliability, and security best practices**.

---

## Completed Exercises

### 1. Infrastructure as Code (IaC)

**Goal:** Provision a secure and scalable cloud infrastructure using Terraform.

**Highlights:**

* AWS VPC with public and private subnets across multiple availability zones
* Application Load Balancer (ALB)
* Auto Scaling Group for application servers
* RDS instance in a private subnet
* S3 bucket for static assets
* IAM roles and security groups following least-privilege principles
* Encryption enabled for data at rest
* Environment-specific configuration via variables

**Outcome:**
A fully reproducible, secure infrastructure defined using Infrastructure as Code, suitable for production workloads.

---

### 2. CI/CD Pipeline Design

**Goal:** Design a production-ready CI/CD pipeline for a Python web application deployed to Kubernetes.

**Highlights:**

* CI/CD pipeline using **GitHub Actions**
* Pipeline stages:

  * Build
  * Automated testing
  * Security scanning
  * Docker image build and scan
  * Deployment to staging and production
* Approval gates for production deployments
* Rollback strategy for failed releases
* Secure handling of secrets and credentials

**Outcome:**
A robust CI/CD workflow that balances developer velocity with reliability, security, and operational safety.

---

### 3. Kubernetes Multi-Tier Application Deployment

**Goal:** Deploy a multi-tier application to Kubernetes with proper resource management and observability.

**Architecture:**

* Frontend: NGINX
* Backend API: Node.js
* Cache: Redis

**Highlights:**

* Kubernetes Deployments with resource requests and limits
* Services (LoadBalancer and ClusterIP)
* ConfigMaps and Secrets (no hard-coded credentials)
* Horizontal Pod Autoscaler (HPA)
* Liveness and readiness probes
* Network Policies for secure pod-to-pod communication
* Designed for local deployment using Minikube

**Outcome:**
A production-aligned Kubernetes setup demonstrating scalability, self-healing, and security best practices.

---

### 4. Production Incident Post-Mortem

**Goal:** Demonstrate incident analysis and operational maturity.

**Scenario Covered:**

* API latency spike from 200ms to 3000ms
* 5% of requests returning 504 Gateway Timeout errors
* Incident duration of 45 minutes during peak traffic

**Highlights:**

* Clear incident timeline
* Root cause analysis methodology
* Identification of monitoring and alerting gaps
* Actionable remediation items with priorities
* Preventive measures to avoid recurrence

**Outcome:**
A structured post-mortem reflecting strong analytical thinking, accountability, and continuous improvement practices.

---

### 5. Automation Script – Cloud Resource Cleanup

**Goal:** Automate cleanup of unused cloud resources to reduce cost and operational overhead.

**Highlights:**

* Python-based script for identifying and removing unused AWS resources:

  * Stopped EC2 instances
  * Unattached EBS volumes
* Configurable via CLI arguments
* Dry-run support
* Error handling and logging
* Unit and/or integration tests included
* Accompanied by usage documentation

**Outcome:**
A safe, configurable automation tool aligned with cost-optimization and operational hygiene practices.

---

## Key Skills Demonstrated

* Infrastructure as Code (Terraform)
* Kubernetes (deployments, scaling, networking, security)
* CI/CD pipeline design and optimization
* Cloud security and least-privilege IAM
* Observability and incident management
* Automation and scripting
* Production mindset and best practices

---

## Assumptions

* AWS is used as the primary cloud provider
* Kubernetes examples target local clusters (Minikube) but are production-aligned
* Secrets are managed securely and not committed to version control
* Exercises focus on architecture, correctness, and best practices rather than UI/UX
---
