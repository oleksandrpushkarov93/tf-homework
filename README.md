# Automate deployment of Versus app to EC2 hosts (Packer, Terraform, GitLabCI)

This is a readme file for a repo that deploys ***Versus App*** on AWS using packer: 

- **Packer** for building AMIs (frontend + backend)
- **Terraform** for infra provisioning (VPC, ALB, ASGs, RDS, IAM, Security Groups)
- **GitLab CI/CD** for automating deployments 
- **AWS SSM Parameter Store** for SSH-less access to EC2 (Session Manager) as well as for the RDS credentials

## 1) Architecture

### Components
- **Frontend**
  React app built into static files, served by **Nginx** , runs on EC2 instances in an **Auto Scaling Group** behind **ALB**

- **Backend**
  Django + Gunicorn on port **8000** that runs on EC2 instances in an **Auto Scaling Group** behind **ALB** (public path `/api/`)

- **Database**
  AWS **RDS MySQL**  Backend connects using env vars from **SSM Parameter Store**

### Traffic Flow
User → **ALB** → (Frontend Target Group / Backend Target Group) → **ASG Instances**  Backend → **RDS MySQL**

---

## 2) Repo Structure

Original app files + packer, terraform and gitlab
.
├── packer/
│   ├── dev.pkrvars.hcl
│   ├── backend.pkr.hcl
│   ├── locals.pkr.hcl
│   ├── plugins.pkr.hcl
│   ├── prod.pkrvars.hcl
│   ├── staging.pkrvars.hcl
│   ├── variables.pkr.hcl
│   ├── frontend.pkr.hcl
│   ├── scripts/
│   ├── systemd/
│   └── nginx/
├── tf-infra/
│   ├── root-module/
│   └── modules/
└── .gitlab-ci.yml

