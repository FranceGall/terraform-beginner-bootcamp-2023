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