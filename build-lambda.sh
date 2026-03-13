#!/bin/bash
set -euo pipefail

# Build and package Lambda function code into lambda.zip
cd "$(dirname "$0")"

zip -j lambda.zip Lambda_Function

cat <<'EOF'
Lambda package created: lambda.zip
Use this file for CloudFormation/Terraform deployment.
EOF
