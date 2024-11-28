Here’s a README file template for your Terraform project:

---

# Kubernetes Deployment with Terraform for Minikube

This project provides a Kubernetes deployment configuration for two environments: **dev** and **prod**. The deployment is managed using Terraform and runs on a Minikube cluster. It includes services like **Nginx** and a **URL Shortener**, exposed via Kubernetes Ingress with environment-specific configurations.

## Table of Contents
- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Deploying the Project](#deploying-the-project)
- [Testing the Deployment](#testing-the-deployment)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Project Overview
This Terraform project manages a Kubernetes deployment for both `dev` and `prod` environments. It includes:
- **Nginx**: A web server exposed on port 80.
- **URL Shortener**: A custom URL shortener service exposed on port 8080.
- Services are exposed via **Ingress** on specific node ports (`30201` for `dev` and `30202` for `prod`).
- **Nginx Index Page**: Custom HTML pages that display environment-specific information.

## Prerequisites
Before using this Terraform configuration, ensure the following:
1. **Minikube** is installed and running on your local machine.
   - Install Minikube: https://minikube.sigs.k8s.io/docs/
2. **Kubectl** is configured to interact with your Minikube cluster.
3. **Terraform** is installed. You can install it from [here](https://www.terraform.io/downloads).
4. The following Minikube addons should be enabled:
   - `ingress`
   - `ingress-dns`

## Installation
1. Clone the repository to your local machine:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Initialize Terraform for both the `dev` and `prod` environments:
   ```bash
   cd dev
   terraform init
   terraform apply
   ```

   Repeat the steps for the `prod` environment:
   ```bash
   cd ../prod
   terraform init
   terraform apply
   ```

## Configuration
The configuration is organized as follows:

- **`dev/terraform.tfvars`**: Variables specific to the development environment, including ports and environment type.
- **`prod/terraform.tfvars`**: Variables specific to the production environment.
- **`main.tf`**: The main configuration file for deploying the infrastructure, including Kubernetes resources, Ingress, and services.
- **`modules/nginx/`**: The Nginx deployment and service configuration.
- **`modules/url_shortener/`**: The URL shortener service configuration.

### Variables
The `terraform.tfvars` file for each environment defines the following:
- `environment`: Specifies the environment (either `dev` or `prod`).
- `nginx_nodeport`: The NodePort for the Nginx service.
- `url_shortener_nodeport`: The NodePort for the URL Shortener service.

## Deploying the Project
1. **Create Kubernetes Cluster with Minikube** (if not done yet):
   ```bash
   minikube start
   ```

2. **Apply the Terraform Configuration** for each environment:
   ```bash
   cd dev
   terraform apply
   ```

   This will set up the Kubernetes namespace, deployments, services, and ingress for the `dev` environment. Repeat the process for `prod`:
   ```bash
   cd ../prod
   terraform apply
   ```

## Testing the Deployment
1. **Get the Minikube IP Address**:
   ```bash
   minikube ip
   ```

2. **Access the Services**:
   - For `dev` environment:
     ```bash
     curl http://<minikube-ip>:30201/
     curl http://<minikube-ip>:30301/
     ```
   - For `prod` environment:
     ```bash
     curl http://<minikube-ip>:30202/
     curl http://<minikube-ip>:30302/
     ```

   You should see the respective environment-specific index page from Nginx and URL Shortener services.

## Troubleshooting
- **Error: Minikube Ingress is not accessible**
  - Ensure that the `ingress` and `ingress-dns` addons are enabled in Minikube:
    ```bash
    minikube addons enable ingress
    minikube addons enable ingress-dns
    ```
- **Issue with Terraform state or environment variables**:
  - Make sure you're applying Terraform configurations in the correct environment folder (`dev` or `prod`).

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

This README covers the basic setup and usage. Let me know if you need any adjustments!
