# Scenario 1



## Description

Create a new EC2 instance and deploy a Webserver with Apache2. In order to accomplish this goal, it is neccesary to:
- Create VPC
- Create Internet Gateway (IGW)
- Create custom route table 
- Create a Subnet
- Associate subnet with route table
- Security group
- Create NIC with an IP in the subnet created in Step 4
- Assign an elastic IP to the network interface create in Step 7 (public IPV4 address)
- Create an Ubuntu server



## Table of Contents

- [Installation](#installation)

- [Usage](#usage)

- [License](#license)

- [Contact](#contact)



## Installation

Provide step-by-step instructions to install and set up your project.

```sh

# Clone the repository

git clone https://github.com/asantar0/aws-terraform.git



# Navigate to the project directory

cd aws-terraform/scenario-1



# Install dependencies

terraform init

```



## Usage

Explain how to use your project. Provide examples or code snippets where applicable.

```sh

# Run the application

terraform plan

terraform apply

```


## License

This project is licensed under the [MIT License](LICENSE).



## Contact

For questions or suggestions, reach out via:

- Email: agustins@root-view.com

- GitHub Issues: [Create an Issue](https://github.com/asantar0/aws-terraform/issues)

