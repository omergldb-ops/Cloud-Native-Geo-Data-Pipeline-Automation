# Cloud-Native Geo-Data Pipeline Automation

## Project Overview
As a Senior Quality Engineer with over 9 years of experience at companies like Payoneer and Intel, I’ve built this project to demonstrate a "Quality-First" approach to infrastructure. This pipeline is designed to be production-ready, focusing on modularity, security (IRSA), and zero-touch automation.

The project implements a full-scale cloud architecture for processing geographic data (GIS).

## Technical Stack
* **Cloud Provider:** AWS (EKS, RDS PostgreSQL, S3, ECR, VPC)
* **Infrastructure as Code:** Terraform (Modular Design, Remote State management)
* **Containerization & Orchestration:** Docker, Kubernetes (EKS), Helm
* **CI/CD:** GitHub Actions
* **Data Layer:** Python (GeoPandas), PostGIS
* **Observability:** Prometheus & Grafana

## Key Engineering Features

### 1. Modular Terraform Architecture
The infrastructure is decoupled into independent modules to ensure maintainability and scalability:
* **VPC Module:** Isolated networking with public/private subnets.
* **IAM Module:** Implementation of **IRSA** (IAM Roles for Service Accounts) for fine-grained security.
* **Compute (EKS) Module:** Managed Kubernetes cluster.
* **Storage & DB Modules:** RDS instance with automated PostGIS extension setup.

### 2. Zero-Touch CI/CD Pipeline
A robust GitHub Actions workflow that handles:
* Infrastructure provisioning via Terraform.
* Automated Docker image builds and pushes to ECR.
* Deployment logic using Helm charts.

### 3. Current Project Status (Development Roadmap)
* **Infrastructure (IaC):** 100% Completed and verified.
* **CI/CD Pipeline:** Fully functional (Terraform & Docker stages).
* **Application Layer:** The Python processing script is currently undergoing refactoring to optimize performance for large-scale spatial datasets. Functional testing of the internal logic is in progress.

## How to Use
1.  **Infrastructure:** Navigate to the `terraform/` directory and run `terraform apply`.
2.  **Deployment:** Push changes to the `main` branch to trigger the GitHub Actions pipeline.