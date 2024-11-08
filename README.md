# CI/CD Pipeline for AWS Lambda Deployment

This repository contains GitHub Actions workflows to automate the deployment of an AWS Lambda function using Terraform. The CI/CD pipeline is designed to build, package, and deploy Lambda code, with infrastructure provisioning done through Terraform.

## Workflow Overview

### 1. Continuous Integration (CI)

The CI part of the pipeline validates changes in the code and infrastructure by performing the following actions:
- Checks out the repository
- Installs dependencies
- Runs tests
- Packages the Lambda function
- Validates Terraform code

### 2. Continuous Deployment (CD)

The CD pipeline deploys the Lambda function to AWS. It leverages Terraform to provision or update infrastructure and GitHub Actions secrets to securely manage access keys.

## Prerequisites

- **AWS Account**: Set up AWS credentials in GitHub Secrets.
- **Terraform**: Ensure Terraform configuration files are set up for Lambda deployment.
- **GitHub Secrets**:
  - `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID
  - `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key
  - `AWS_REGION`: The AWS region where the Lambda function will be deployed

## Workflow Configuration

### File Structure

- **Lambda Function**: Place the Lambda code in a dedicated directory, e.g., `/lambda`.
- **Terraform Configuration**: Define Terraform configuration in `/terraform` or similar directory.

### Workflow File

The workflow file (`.github/workflows/lambda-deployment.yml`) includes both CI and CD steps for Lambda deployment.

### Example Workflow

```yaml
name: Lambda CI/CD Pipeline

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Node.js (if using Node.js runtime)
        uses: actions/setup-node@v2
        with:
          node-version: '14' # Adjust based on runtime

      - name: Install dependencies
        run: npm install
        working-directory: ./lambda # Adjust to Lambda code directory

      - name: Run tests
        run: npm test
        working-directory: ./lambda # Adjust to Lambda code directory

      - name: Package Lambda function
        run: |
          zip -r function.zip ./
        working-directory: ./lambda
        continue-on-error: false

  deploy:
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.4.0 # Adjust Terraform version as needed

      - name: Terraform Init
        run: terraform init
        working-directory: ./terraform # Adjust to Terraform directory

      - name: Terraform Plan
        run: terraform plan -out=tfplan
        working-directory: ./terraform

      - name: Terraform Apply
        run: terraform apply -auto-approve tfplan
        working-directory: ./terraform
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_REGION: ${{ secrets.AWS_REGION }}
