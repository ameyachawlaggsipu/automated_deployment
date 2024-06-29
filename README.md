# Automated Deployment Project

This project demonstrates automated deployment of a portfolio website using AWS S3, AWS CloudFront, and Terraform.

## Table of Contents
- [Overview](#overview)
- [Setup](#setup)
- [Usage](#usage)
- [Folder Structure](#folder-structure)
- [Contributing](#contributing)
- [License](#license)

## Overview

The project uses Terraform for infrastructure as code to deploy a portfolio website on AWS:
- Creates an S3 bucket to store website files.
- Configures AWS CloudFront for efficient content delivery.
- Provides a basic HTML portfolio website.

## Setup

To run this project locally or deploy it to your AWS account, follow these steps:
1. Clone the repository: `git clone https://github.com/ameyachawlaggsipu/automated_deployment.git`
2. Install Terraform (version >= 0.15) on your local machine.
3. Configure AWS credentials with appropriate permissions.
4. Update `main.tf` with your preferred settings (e.g., bucket name, region) and update your resume details in index.html.
5. Deploy the infrastructure by running:
 ```bash
   terraform init
   terraform plan 
   terraform apply
```
## Usage

Once deployed, your portfolio website will be accessible via AWS CloudFront with the URL provided in the Terraform output.

## Folder Structure
```
automated_deployment/
│
├── main.tf # Terraform configuration file
└── website_code/
    └── index.html # Sample HTML for portfolio website
```

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your improvements.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
