# AWS Serverless Data Pipeline (CSV → BI)

## 🚀 Project Overview
This repository implements a fully automated serverless data pipeline on AWS that ingests raw CSV files from S3, transforms data using Lambda and Glue, and publishes a polished business intelligence dashboard in QuickSight.

### Key outcomes
- Ingest raw CSV data from S3
- Run automated transformation and enrichment
- Store curated results in a query-ready destination
- Build a modern BI dashboard in QuickSight

## 🧭 Architecture
1. CSV upload to S3 triggers Lambda
2. Lambda validates data and starts Glue ETL
3. Glue jobs transform and write output to S3/Athena-optimized store
4. QuickSight connects to transformed dataset and renders dashboards

## 🧩 Components
- `AWS Lambda`: event-driven orchestration and validation
- `AWS Glue`: serverless ETL transformation
- `Amazon S3`: raw and transformed data storage
- `Amazon QuickSight`: BI dashboard report and analytics

## 📦 What’s Included
- AWS Lambda function(s) code in `Lambda_Function/`
- CloudFormation or deployment templates (if present)
- README with architecture and usage

## ⚙️ How to Use
1. Build and package Lambda: `./build-lambda.sh`
2. Deploy the stack using CloudFormation or Terraform (see `IaC Deployment/README.md`).
3. Create separate S3 buckets (e.g., Raw (for unfiltered data), Processed, and final). 
4. Upload raw CSV to the configured raw S3 input bucket.
5. Lambda triggers and starts Glue ETL (or processes CSV to output bucket in this sample).
6. Configure Crawlers and ETL Job to transform processed CSV data to Final S3 bucket
7. Connect QuickSight to transformed data.
6. Visualize

## 📌 Notes
- This pipeline is designed for end-to-end automation and minimal manual operations.
- Extend quickly by adding more validation in Lambda, additional Glue transformations, or QuickSight parameters.

## 🧱 IaC Deployment
This project includes an `IaC Deployment` folder with example templates:
- CloudFormation: `IaC Deployment/pipeline-stack.yml`
- Terraform: `IaC Deployment/main.tf`, `IaC Deployment/variables.tf`, `IaC Deployment/outputs.tf`

### CloudFormation
```bash
aws cloudformation deploy \
  --stack-name aws-data-pipeline \
  --template-file "IaC Deployment/pipeline-stack.yml" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides S3InputBucket=<your-input-bucket> S3OutputBucket=<your-output-bucket>
```

### Terraform
```bash
cd "IaC Deployment"
terraform init
terraform plan -out plan.tfplan
terraform apply plan.tfplan
```

---
