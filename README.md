# Infrastructure Repository README

This README describes the **infrastructure-only repository** responsible for provisioning and managing the AWS environment required to run the EKS cluster and all supporting services.

This document reflects the state *before integrating Helm charts and ArgoCD GitOps*. It provides clarity on the infra architecture, pipeline behavior, required tools, and expected workflow.

---

# 📌 Current Working Commit SHA

```
74b7efe1cf65271b4c0757f8a085708f24705e8d
```

This represents the stable state before transitioning to Helm and ArgoCD._

---

# 📌 Overview

This repository contains **Terraform configurations** used to provision all AWS resources required for running applications on Amazon Elastic Kubernetes Service (EKS).

The repository is fully automated using a CI/CD pipeline and is responsible ONLY for infrastructure—not application deployments.

---

# 🏗️ Components This Repo Provisions

### **1. Networking (VPC Layer)**

* VPC
* Public and private subnets
* Route tables
* NAT Gateway
* Internet Gateway
* Subnet associations

### **2. EKS Cluster**

* EKS cluster
* Node groups (Managed or Self-managed)
* IAM roles for cluster and nodes

### **3. IAM Roles**

* Cluster IAM role
* Node group IAM roles

### **4. Outputs**

* What ever needed

---

# 🚀 CI/CD Pipeline Behavior

This repository uses **GitHub Actions** for automating infrastructure deployment. AWS credentials are securely stored in **GitHub Repository Secrets**, and Terraform retrieves configuration values from **SSM Parameter Store** based on environment names (e.g., `dev`, `prod`).

Below is the original pipeline description:

A dedicated CI/CD pipeline automates Terraform actions.

### **Pipeline Steps:**

1. **terraform fmt** → Format check
2. **terraform init** → Initialize backend and providers
3. **terraform validate** → Validate configuration
4. **terraform plan** → Show changes
5. **terraform apply** (manual approval required) → Provision infra

### **Destroy Workflow:**

* Before running `terraform destroy`, Kubernetes workloads must be removed.
* This ensures no load balancers or ENIs block subnet or VPC deletion.

---

# 🔧 Tools Used

### **Terraform**

Used as IaC tool to manage AWS resources.

### **AWS CLI**

Required for authentication and EKS kubeconfig creation.

### **kubectl** (only for verification)

Used to verify cluster readiness after provisioning.

---

# 🔑 Prerequisites

* Terraform 1.34
* AWS account + IAM user/role with required permissions
* AWS CLI configured locally or in CI
* S3 + DynamoDB table for remote backend (if configured)

---

# 🧪 Environment Handling

This repository currently uses a **single-branch model**, but supports **multiple environments** (e.g., `dev`, `stage`, `prod`) dynamically based on the environment name passed through the pipeline. for now env is passed as default variable

### **How multi-environment logic works now:**

* GitHub Actions passes an environment variable (e.g., `ENV_NAME=dev`).
* Terraform reads environment-specific parameters from **AWS SSM Parameter Store**.
* Resource names, tags, and configurations adjust automatically based on the environment.

This allows a single codebase to manage multiple environments without branches.

---

# 🔒 Future: Multi-GitHub Environment Support + Approval Gates

A planned enhancement is to move to **GitHub Environments**, each with:

* Deployment protection rules
* Manual approval gates for production
* Dedicated secrets per environment
* Audit logs for changes made to `prod`

The future workflow will be:

1. Push to `main`
2. GitHub Actions selects the correct environment (dev / stage / prod)
3. Production requires manual approval before `terraform apply`

This ensures a more secure and standard deployment structure.

---

# 🧪 How to Deploy

### **1. Initialize Terraform**

```
terraform init
```

### **2. Review plan**

```
terraform plan
```

### **3. Apply changes**

```
terraform apply
```

After apply, configure kubeconfig:

```
aws eks update-kubeconfig --name <cluster-name> --region <region>
```

---

# 🗑️ Destroying Infrastructure

Before destroying, ensure **all workloads are deleted** from the EKS cluster:

```
kubectl delete ns <application-namespace>
```

Then run:

```
terraform destroy
```

---

# 🎯 Next Steps (Planned Enhancements)

* Install ArgoCD using Terraform Helm provider
* Manage cluster add-ons using Helm charts
* Transition to GitOps model

---
