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
We need to geenrate AWS CLI credits from IAM User in order to the user AWS CLI (Client Secret)

#### AWS Keys to store in Terminal
export AWS_ACCESS_KEY_ID='AKIAZKA56EXAMPLE'
export AWS_SECRET_ACCESS_KEY='ricAwsSDDqvkpe5YbtVcdSvsEXAMPLE'
export AWS_DEFAULT_REGION=us-east-1

#### AWS Keys to store in Gitpod
gp env AWS_ACCESS_KEY_ID='AKIAZKA56EXAMPLE'
gp env AWS_SECRET_ACCESS_KEY='ricAwsSDDqvkpe5YbtVcdSvsEXAMPLE'
gp env AWS_DEFAULT_REGION=us-east-1