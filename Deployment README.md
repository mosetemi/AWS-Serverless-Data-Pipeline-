# IaC Deployment

This folder contains Infrastructure-as-Code examples for deploying the serverless pipeline stack. Use CloudFormation for native AWS deployment or Terraform for repeatable infrastructure.

## Prerequisites
- AWS CLI configured with credentials
- Terraform installed (for Terraform path)
- Build and package the Lambda function

### Build Lambda package
From repo root:
```bash
./build-lambda.sh
``` 
This generates `lambda.zip` in project root.

### Upload Lambda package to S3 (required by CloudFormation)
```bash
aws s3 cp lambda.zip s3://<your-code-bucket>/lambda-code.zip
```

## CloudFormation Example
- File: `pipeline-stack.yml`
- Deploy:
  ```bash
  aws cloudformation deploy \
    --stack-name aws-data-pipeline \
    --template-file "IaC Deployment/pipeline-stack.yml" \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
      S3InputBucket=<your-input-bucket> \
      S3OutputBucket=<your-output-bucket> \
      LambdaCodeS3Key=lambda-code.zip
  ```

## Terraform Example
- Files: `main.tf`, `variables.tf`, `outputs.tf`
- Deploy:
  ```bash
  cd "IaC Deployment"
  terraform init
  terraform plan -out plan.tfplan \
    -var "s3_input_bucket=<your-input-bucket>" \
    -var "s3_output_bucket=<your-output-bucket>" \
    -var "lambda_zip_path=../lambda.zip"
  terraform apply plan.tfplan
  ```

### After deployment
1. Upload raw CSV to input bucket, e.g. `s3://<your-input-bucket>/raw/data.csv`.
2. Confirm event triggers Lambda and processed output appears under `processed/` in output bucket.
3. Connect QuickSight to output bucket/Athena table for dashboards.

