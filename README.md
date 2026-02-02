# AWS-Terraform-Demonstration

## Table of Contents

- [AWS-Terraform-Demonstration](#aws-terraform-demonstration)
  - [Overview](#overview)
    - [Infrastructure Variables](#infrastructure-variables)
    - [Deployment Flow](#deployment-flow)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Run the application](#run-the-application)
  - [Contributions](#contributions)
  - [License](#license)

## Overview

This project uses [Terraform](https://developer.hashicorp.com/terraform) to deploy a simple infrastructure on [Amazon Web Services (AWS)](https://aws.amazon.com/), simulated with [LocalStack](https://www.localstack.cloud/).

It provisions an [Amazon EC2](https://aws.amazon.com/ec2/) instance based on an Ubuntu 22.04 Amazon Machine Image ([AMI](https://docs.aws.amazon.com/es_es/AWSEC2/latest/UserGuide/AMIs.html)), which installs [Docker](https://www.docker.com/) at startup and runs a Dockerized API exposed on port 3000.

The infrastructure follows infrastructure-as-code best practices by storing the Terraform state in an [Amazon S3](https://aws.amazon.com/es/s3/) bucket (also simulated) and configuring a minimal [Amazon Virtual Private Cloud (VPC) Security Group](https://docs.aws.amazon.com/es_es/vpc/latest/userguide/vpc-security-groups.html), allowing only the required inbound traffic on port 3000. All resources are fully **customizable**, **automated** and **easily reproducible**.

### Infrastructure Variables

Variables are defined in `variables.tf` and assigned in `terraform.tfvars`.

| Variable                | Description                                          |
| ----------------------- | ---------------------------------------------------- |
| **aws_region**          | AWS region (eu-west-1)                               |
| **instance_type**       | EC2 instance type (t3.medium)                        |
| **ami**                 | AMI Identifier (simulated in LocalStack)             |
| **name**                | EC2 instance name                                    |
| **localstack_endpoint** | LocalStack endpoint                                  |
| **localstack_dummy**    | Dummy value for AWS credentials                      |

### Deployment Flow

1. Terraform initializes the Amazon S3 bucket in LocalStack to store the infrastructure state
2. A Security Group is created, allowing inbound traffic on port 3000
3. An Amazon EC2 instance is launched
4. During instance startup, the `user_data.sh` script:
   1. Installs Docker
   2. Runs a Dockerized API exposing port 3000
5. Terraform displays the final deployment outputs:
    ```bash
    aws_security_group.security_group: Creating...
    aws_security_group.security_group: Creation complete after 3s [id=sg-4588e69c160ce9392]
    aws_instance.instance: Creating...
    aws_instance.instance: Still creating... [00m10s elapsed]
    aws_instance.instance: Creation complete after 11s [id=i-25c47259bd4b66f09]

    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

    Outputs:

    instance_name = "test"
    instance_type = "t3.medium"
    ```

## Installation

### Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/install):
    ```bash
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
    ```

- Have [Docker](https://docs.docker.com/engine/install) installed on your machine

- Have a [Docker Hub](https://hub.docker.com/) account

You do not need to have real AWS credentials, as the deployment is done against LocalStack.

### Run the application

- Clone the repository:
    ```shell
    git clone https://github.com/antonioalanxs/AWS-Terraform-Demonstration
    cd AWS-Terraform-Demonstration
    ```

- Go to the Docker directory and start LocalStack service:
    ```shell
    cd AWS-Terraform-Demonstration/docker
    docker compose up
    ```

- Go to the Terraform directory and execute the `run.sh` script:
    ```shell
    cd ../terraform
    ./run.sh
    ```

## Contributions

This project was created as a technical assessment, but contributions are welcome.

1. Fork the repository
2. Create a new branch for your feature or bug fix (`git checkout -b feature/new-feature`)
3. Make your changes and commit them following the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format (`git commit -m 'feat: add new feature'` or `fix: correct a bug`)
4. Push your branch to the remote repository (`git push origin feature/new-feature`)
5. Create a Pull Request

## License

This project is licensed under the [Apache License 2.0](./LICENSE).
