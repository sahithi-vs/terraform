#!/bin/bash

# List of random Terraform-related commit messages
messages=(
  "Update Terraform backend configuration"
  "Refactor variable declarations"
  "Add new AWS provider version"
  "Fix security group ingress rule"
  "Optimize Terraform plan output"
  "Update module source path"
  "Add tags to EC2 instances"
  "Refactor outputs for clarity"
  "Fix typo in variable description"
  "Improve Terraform formatting and linting"
)

# Create a dummy file if not exists
touch main.tf

# Loop to create 10 commits
for i in {1..10}
do
  echo "# Change $i" >> main.tf
  git add -A
  message=${messages[$RANDOM % ${#messages[@]}]}
  git commit -m "$message"
done


