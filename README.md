# 🚀 CI/CD Pipeline for Provisioning EC2 using Terraform

This repository demonstrates a GitHub Actions CI/CD pipeline that automatically provisions an **AWS EC2 instance** using **Terraform** when changes are pushed to the `main` branch.

## 📁 Project Structure

```bash 
├── .github
│ └── workflows
│ └── main.yml # GitHub Actions workflow file
├── terraform/
│ └── main.tf # Terraform configuration files
│ └── variables.tf
│ └── terraform.tfvars
└── README.md
└── .gitignore

```

## ⚙️ What It Does

- **Checkout Code** from GitHub.
- **Setup Terraform** CLI in the GitHub Actions runner.
- **Initialize Terraform** configuration.
- **Apply Terraform Plan** using secret variables to:
  - Provision an EC2 instance on AWS.
  - Inject SSH keys securely via GitHub Secrets.
- **Output** a success message after provisioning.

---

## 🔐 GitHub Secrets Required

Ensure the following secrets are configured in your GitHub repository:

| Secret Name     | Description                      |
|-----------------|----------------------------------|
| `ACCESS_KEY`    | Your AWS IAM Access Key ID       |
| `SECRET_KEY`    | Your AWS IAM Secret Access Key   |
| `PUBLIC_KEY`    | SSH Public Key for EC2 access    |
| `PRIVATE_KEY`   | SSH Private Key for EC2 access   |

To add these:
1. Go to your GitHub repo → `Settings` → `Secrets and variables` → `Actions`.
2. Add each secret by name and paste the corresponding value.

---

## ✅ How to Use


1. Clone this repo and navigate to the project directory.
2. Modify the Terraform configuration under `/terraform` as needed.
3. Push changes to the `main` branch — the pipeline will trigger automatically.

