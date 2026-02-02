#!/bin/bash

terraform init -backend-config=backend.hcl
terraform plan
terraform apply -auto-approve
terraform output > "outputs.txt"