# Terraform Beginner Bootcamp 2023
## Semantic Versioning :mage:

Given a version number **MAJOR.MINOR.PATCH**, eg. `1.3.56` increment the:

thie project is going to utilize semantic versioning for its tagging.
[semver.org](http://semver.org)

**MAJOR** version when you make incompatible API changes
**MINOR** version when you add functionality in a backward compatible manner
**PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/
### Consideration withthe Terrform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So the original gitpod.yml bash from Andrew was really sloppy and needed to be changed.

### Consideration for Linux Distribution
```
This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly...
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```
### Refactoring into Bash Scripts
While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI. See[lamby.cloud](lamby.cloud) for executable bash naming convention within a .bin directory is common.

This bash script is located here: [./bin/install_terraform_cli]
- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allows us an easier process to debug and execute manually Terraform CLI install
- This will allow better portability or other project that  need to install Terrafomr CLI.
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Shebang
Tells the bash script what program that will interpret the script:`#!/bin/bash`
[Sha-bang](https://en.wikipedia.org/wiki/Shebang_(Unix))

Chat GPT recommends this format for portability:
`!#/usr/bin/env bash`
When executing the bash script we can use the `./` shorthand notification to execute the bash script.

### Linux Permissions
CHMOD is used to update permissions on a file or folder. For example, we could use CHMOD 777 filename to grant access to everything. OWNER.GROUP.OTHER
[Linux Permissions](https://en.wikipedia.org/wiki/File-system_permissions)

### Gitpod Lifecycles (Before, Init, Command)
We need to be careful when using the Init because it will not rerun if we restart an existing workspace.
Used by the file [.gitpod.yml](.gitpod.yml)
https://www.gitpod.io/docs/configure/workspaces/tasks

### Execution Considerations

When executing the bash script in the Terminal, we can use the `./` shorthand notation to execute the bash script.
eg. `./bin/isntall_terraform_cli`

If we are using a script in .gitpod.yml we need to point the script to a program to interpret and execute it.
eg. `source ./bin/install_terraform_cli`

Permissions required at the user mode.
```sh
chmod u+x ./bin/install_terraform_cli
```
alternatively:
```
chmod 744 ./bin/install_terraform_cli
```

#### Working with ENV vars

We can list out all Environment Variables (ENV Vars) using the `env` command
We can filter specific ENV Vars using grep eg. ` env | grep GITPOD`
In the terminal we can set using `export HELLO='world'
In the terminal we can unset value of ENV Var using `unset HELLO`
We can set an ENV Vat temporarely when just running a command

```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set ENV without writing export eg. 
```
HELLO='world

echo $HELLO
```

#### Printing Vars
We can print an ENV Var using echo eg `echo $HELLO`

#### Scoping of ENV Vars
When you open up new bash terminals in VSCODE it will not be aware of ENV Vars that you have set in another window.
If you want to ENV Vars to persist across all future bash terminals that are open need to set env vars in your bash profile eg. `.bash_profile`

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage eg. 
```
gp env HELLO='world'
```
### AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_terraform_cli)

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configured correctly by running the following AWS command: 
```sh
aws sts get-caller-identity
```
IF there is any valid user, you'll get something like this:
```
{
    "UserId": "AIDAZKA565WVBWLTPROUT",
    "Account": "640012971074",
    "Arn": "arn:aws:iam::640012971074:user/terraform-beginner-bootcamp-patrick"
}
```
We need to generate AWS CLI credits from IAM User in order to the user AWS CLI (Client Secret)

#### AWS Keys to store in Terminal
export AWS_ACCESS_KEY_ID='AKIAZKA56EXAMPLE'
export AWS_SECRET_ACCESS_KEY='ricAwsSDDqvkpe5YbtVcdSvsEXAMPLE'
export AWS_DEFAULT_REGION=us-east-1

#### AWS Keys to store in Gitpod
gp env AWS_ACCESS_KEY_ID='AKIAZKA56EXAMPLE'
gp env AWS_SECRET_ACCESS_KEY='ricAwsSDDqvkpe5YbtVcdSvsEXAMPLE'
gp env AWS_DEFAULT_REGION=us-east-1

## Terraform Basics
### Terraform Registry - file main.tf
Use Random from Terraform
[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs)

Terraform source their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interfce to APIs that will allow to create resources in Terraform
- **Modules** are a way to make large amount of Terraform code modular, portable and sharable.

### Terraform Console
We can see a list of all Terraform commands by typing `terraform`

### Prepare working directory for other Terraform commands:
terraform       --> help

#### Terraform init 
`terraform init`
At the start of a new Terrafrom project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project
- creates 1 folder and 1 file: .terraform>terraform-provider-random_v3.5 &.terraform.lock.hcl

#### Terraform plan 
`terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed.
We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.
- create a change set (file as is and planned changed)

#### Terraform apply
`terraform apply`
This will run a plan and pass the changeset to be executed by terraform. Apply should prompt yes or no.
- generate delta plan and execute terraform plan.

If you want to automatically approve an apply we can provide the auto approve flag eg. 
`terraform apply --auto-approve` 
- apply with auto approval

#### Terraform Destroy
`terraform destroy`
This will destroy resources.
You can also use the --auto-approve to destroy and skip the approve check.

#### Terraform Lock Files
`.terraformlock.hcl` contains the locked versioning for the providers or modules that should be used with this project
The Terraform Lock File should be commited to your **Version Control System** eg. GitHub

#### Terraform State Files
`.terraform.tfstate` contain information about the current state of your infractructure.
This file **should not be commited** to your VCS.
This file can contain sensitive data.
If you lose this file, you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory
`terraform plan`

#### Terraform token
When attempting to run `terraform login` it will open a new screen but doesn't accept the token. In order to login into Terraform we need to create a token in Terraform and add the value of the token inside the file "credentials.tfrc.json" 
terra-house-superfly

- Create new token 
```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```
- Create the new file 
```
touch /home/gitpod/.terraform.d/credentials.tfrc.json
```
- Edit the file       
```
open /home/gitpod/.terraform.d/credentials.tfrc.json
```
{
     "credentials": {
        "app.terraform.io": {
            "token": "EXAMPLE_tlasv1.66vItB6IqAFGbtZRXLVTrwbz5Fk8jDzdhsdYFm7CzpZafOG9FEG9AYtB6XM8lOmnGjc"
        }
     }
}
```

## Git Commands from Bash in Gitpod

Pull latest from GitHub
```
git pull
```
Fetch GitHub
```
git fetch
```
Get All
```
git add .
```
Save temporarely until we can select our branch
```
git stash save
```
Return to Main branch in Gitpod with this bash command;
```
git checkout main
```
Apply Tag after checkout
```
git tag 0.7.0
```
Send the tag to GitHub
```
git push --tags
## Automated Terraform Cloud Token Credentials by creating a bash file for TERRAFORM_CLOUD_TOKEN
See file ./bin/generate_trfc_credentials for bash

## Create Terraform Alias TF with bash
See file ./bin/set_tf_alias , also executed from gitpod.yml
```sh
open ~/.bash_profile
```
Add the following string into the file
```
alias tf="terraform"
```
To load bash profile into memory to be available for execution
```
source ~/.bash_profile
```
Defining the bash to add automatically (alias tf="terraform") into the bash profile file. Otherwise we would need to execute the `source ~/.bash_profile`` command each time we create a new workspace.
