📘 **MODULE 1: Getting Started with Terraform and Infrastructure as Code**  
- What is Infrastructure as Code (IaC)? Why it matters for reliability and repeatability  
- Terraform vs Ansible: When to use each (Terraform for provisioning, Ansible for configuration)  
- Installing Terraform on macOS (Homebrew), Linux (package manager or binary), Windows (Chocolatey or manual)  
- Verifying installation and setting up your first project folder  

**Lab 0**: Install Terraform on your machine. Create a folder called `lab1`. Run `terraform version` and confirm it works. Write a short README explaining what IaC is in your own words.

**Lab 1**: Launch your first instance using terraform . and document the process in the README file.

---

📘 **MODULE 2: Core Configuration Blocks**  
- Providers: Declare cloud platforms (AWS, Azure, GCP) with authentication  
- Resources: Define real infrastructure (e.g., AWS EC2 instance, vpc, subnet)  
- Data Sources: Fetch info about existing resources (e.g., AMI ID, region zones)  
- Output Blocks: Expose useful values like public IPs or DNS names  
- Input Variables: Parameterize your config (e.g., instance type, region)  
- Local Variables: Store intermediate values for reuse  
- Sensitive Variables: Mark secrets (like passwords) to hide them in output  

**Lab 2**: install apache server on ec2 

**Lab 3**: Deploy a static website on ec2 instance using terraform. Use variables, output the instance public ip. Run `terraform apply` and verify in the cloud console.

---

📘 **MODULE 3: Variable Data Types and Structuring Inputs**  
- Basic types: string, number, bool  
- Collections: list(string), list(number), map(string)  
- Complex types: object({}) for structured inputs (e.g., { name = "web", size = "t3.micro" })  
- Default values and validation rules (e.g., min length, allowed values)  

**Lab 4**: DEploy 2-tier architecture using terraform

---

📘 **MODULE 4: State Management and Backends**  
- What is the `terraform.tfstate` file? Why it’s critical  
- Local backend: Default behavior (state stored on your machine)  
- Remote backend: Store state securely in S3 (AWS) or Terraform Cloud  
- Backend block configuration (bucket, key, region)  
- State locking with DynamoDB (to prevent concurrent changes)  
- Migrating from local to remote state safely  

**Lab 5**:  Migrate your local state to S3 using a backend block. Confirm state is now remote by running `terraform apply` from a different machine or folder.

---

📘 **MODULE 5: Terraform Workflow and Team Collaboration**  
- Core commands: `init`, `fmt`, `validate`, `plan`, `apply`, `destroy`  
- What each command does and when to use it  
- The standard team workflow: write → format → validate → plan → code review → apply  
- Why every change must go through version control (Git)  
- `.gitignore` best practices (never commit `.tfstate` or secrets)  

**Lab  6**: Create a cicd pipeline in github action for Terraform code.  Run the full workflow (`fmt` → `validate` → `plan` → `apply`). Commit and push your code.

---

📘 **MODULE 6: Provisioners, Modules, and Reusability**  
- Provisioners: `local-exec` (run locally), `remote-exec` (run on instance)  
- When to avoid provisioners (use cloud-init or config tools like Ansible instead)  
- Creating your own modules: folder structure, `variables.tf`, `outputs.tf`, `main.tf`  
- Using public modules from registry.terraform.io (e.g., AWS VPC module)  
- Composing modules: calling one module inside another  
 
**Lab 7**:  Deploy 2-tier architecture using terraform modules, refactor the 2-tier archichecture lab to use modules.

---

📘 **MODULE 7: Production-Ready Patterns and Security**  
- Folder structure for multi-environment: `/env/dev`, `/env/staging`, `/env/prod`  
- Isolating environments with separate state files or workspaces  
- CI/CD integration: Run `terraform plan` in pull requests, `apply` on merge (using GitHub Actions or GitLab CI)  
- Security scanning: Run `tfsec` or `checkov` in CI to catch misconfigurations  
- Documenting modules and keeping READMEs up to date  

**Lab 8**: Deploy a secure, production-like web application using Terraform

**Lab 9**: Deploy a  microservice application on ecs manually using the console

**Lab 10**: Deploy a  microservice application on ecs using terraform

**Lab 11**: Deploy a  microservice application on eks using ekctl

**Lab 12**: Deploy a  microservice application on eks using terraform 

**Lab 13**: Deploy a  microservice application on eks using terraform modules
---


### 🔚 Final Projects: Full-Stack Cloud Deployment  


1- Launch your first instance using terraform

2- install apache server on ec2 using terraform

3- Deploy a static website on ec2 instance using terraform

4- Automate the deployment process of Jenkins using terraform and bash script

5- create Iam roles and policies using terraform

6- create Iam users and groups using terraform

7- Deploy 2-tier architecture using terraform

8- Deploy 2-tier architecture using terraform using modules

9- Create a cicd pipeline in github action for Terraform code.  Run the full workflow

9- Deploy a secure, production-like 3 tier web application using Terraform

10- Deploy a  microservice application on ecs manually using the console

11- Deploy a  microservice application on ecs using terraform

12- Deploy a  microservice application on eks using ekctl

13- Deploy a  microservice application on eks using terraform 

14- Deploy a  microservice application on eks using terraform modules

| # | Project | Links | Description | Module |
|---|--------|-------|-------------|--------|
| 1 | Launch your first instance using Terraform | — | Create and manage a basic EC2 (or equivalent) virtual machine using Terraform. | Module 1 |
| 2 | Install Apache server on EC2 using Terraform | — | Provision an EC2 instance and use a provisioner or user data to install and start Apache. | Module 1 |
| 3 | Deploy a static website on EC2 instance using Terraform | — | Host a simple HTML site on an EC2 instance with Apache, fully automated via Terraform. | Module 2 |
| 4 | Automate the deployment process of Jenkins using Terraform and bash script | — | Deploy a Jenkins server on EC2 using Terraform and configure it via a startup bash script. | Module 3 |
| 5 | Create IAM roles and policies using Terraform | — | Define and manage AWS IAM roles and custom policies as code. | Module 7 |
| 6 | Create IAM users and groups using Terraform | — | Manage IAM users, groups, and group memberships using Terraform resources. | Module 7 |
| 7 | Deploy 2-tier architecture using Terraform | — | Build a basic two-tier app (web + DB) in a single VPC with security groups and networking. | Module 3 |
| 8 | Deploy 2-tier architecture using Terraform using modules | — | Refactor the 2-tier architecture into reusable Terraform modules for better maintainability. | Module 6 |
| 9 | Deploy a secure, production-like 3-tier web application using Terraform | — | Implement a full 3-tier architecture (frontend, app, DB) with private/public subnets, load balancer, and secure networking. | Module 7 |
| 10 | Deploy a microservice application on ECS manually using the console | — | Gain hands-on experience by deploying containers on AWS ECS via AWS Console (non-Terraform baseline). | Module 7 |
| 11 | Deploy a microservice application on ECS using Terraform | — | Automate ECS cluster, task definitions, and service deployment using Terraform. |  Module 7 |
| 12 | Deploy a microservice application on EKS using eksctl | — | Use eksctl (not Terraform) to create and deploy to an EKS cluster—understanding prerequisite tooling. | Module 7 |
| 13 | Deploy a microservice application on EKS using Terraform | — | Provision EKS cluster, node groups, and deploy apps using native Terraform AWS EKS resources. | Module 7 |
| 14 | Deploy a microservice application on EKS using Terraform modules | — | Use or build reusable modules to deploy EKS-based microservices with best practices. |  Module 7 |