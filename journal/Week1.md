# Terraform Beginner Bootcamp 2023 - Week 1 Summary

## Root module structure
```
PROJECT_ROOT
|
├── main.tf           # Everything else
├── variables.tf      # Store structure of input variables
├── terraform.tfvars  # Variables to load into our terraform project
├── providers.tf      # Define required providers and configuration
├── output.tf         # Store outputs
└── README.md         # Required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables
[Terraform Variables](https://developer.hashicorp.com/terraform/language/values/variables)

In terraform we have two kinds of variables:
- **Environment variables** set in bash terminal eg. AWS
- **Terraform variables**   set in tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibility in the UI eg.
```
terraform plan -var user_uuid="db8gf987-9876-9875-b2d5-12k56k5k3kk3"
```

### Loading Terraform Input Variables

We can use the `var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user-id"`

### Var-File Flag

Set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file:
```
terraform apply -var-file="testing.tfvars"
```

### terraform-tfvars

This is the default file to load in terraform variables in bunk

### auto-tfvars

Terraform also automatically loads a number of variable definitions files if they are present:
- Files named exactly terraform.tfvars or terraform.tfvars.json.
- Any files with names ending in .auto.tfvars or .auto.tfvars.json.

### Terraform load variables order
...with later sources taking precedence over earlier ones;

- Environment variables
- The terraform.tfvars file, if present.
- The terraform.tfvars.json file, if present.
- Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
- Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

## Dealing with Configuration Drift

## What happen when losing our Terraform state file?

If we lose ouor statefile, you most likely have to tear down all you cloud infractructure manually.

You can use Terraform import but it won't work for all cloud resources. You need to check the terraform providers documentation for which resource support import.

### Fix Missing Resource with Terraform Import

`terraform import aws_s3_bucket.bucket <bucket-name>`

eg. terraform import aws_s3_bucket.example hfqbnr2rfx3jkcsa

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/)

### Fix using Terraform Refresh

```sh
terraform apply -refresh-only --auto-approve
```

## Terraform Module

### Terraform Module Structure

It is recommended to place modules in a `module` directory when locally developing modules, 
but you can name it whatever you like.

Separate the application into two modules:
-- CDN
|-- Cloudfront Distribution
|-- Origin Access Controls
-- Storage
|-- Bucket Policy
|-- S3 Bucket
|-- Static Website Hosting
|-- AWS Caller Identity Current

### Passing Input Variables
We can pass input variables into our module, 
the module has to declare the terraform variables in its own variables.tf
```tf
module terrahouse_aws" {
  user_uuid = var.user.uuid
  bucket_name = var.bucket_name
```

### Modules Sources
Using the source we can import the module from various plages eg:
- locally
- GitHub
- Terraform Registry

```tf
module terrahouse_aws" {
  source = "./modules/terraform_aws"
```

##Considerations when using ChatGPT to get Terraform code

LLMs such as ChatGPT may not be trained up to date from the latest documentation.
It will most likely generate code based on previous older versions which may be deprecated today.

## Working with Files in Terraform

### FileExists Function
#https://developer.hashcorp.com/terraform/language/functions/fileexists
Terraform function checks the existance of a file.

```tf
condition = fileexists(vat.error_html_filepath)
```

### Filemd5 
#https://developer.hashicorp.com/terraform/language/functions/filemd5


### Path Variable

In terraform there is a special variable called `path` that allows to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module of the project
[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

## Fixing Tags in Graph
[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Delete Local Tag
```sh
git tag - d <tag_name>
```

Delete Remote Tag
```sh
git push --delete origin <tag_name>
```

Checkout the Commit that you want to retag. Get the corresponding SHA for the branch from GitHub history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

## Terraform Locals
Locals allows us to define local variables.
It can be very useful when we need transform data into another format and have referenced a variable.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources
This allows sourcing data from cloud resources.
Useful to reference cloud resources (values) without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON
We use the **jsonencode** to create the json policy inline in the hcl code statement.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing Lifecycles of Resource

[Meta Arguments Lifecycles](http://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables have no impact on TF Plan, and consequently aren't valid in replace_triggered_by. Use Terraform data to capture any input change to trigger replacement.

[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners

Provisioners allow you to execute commands on compute instances eg. AWS CLI command. 
They are not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioner]{https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax}
### Local-exec

This will execute command on the machine running the terraform command eg. plan apply


```tf
resource "aws_instance" "web" {
  provisioner "local-exec" {
    command = "echo The server's IP
    address is ${self.private_ip}"
  }
}
```

### Remote-exec

[local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

This will execute commands on a machine which you target. You will need to provide credentials such as SSH to get into the machine.

```tf
resource "aws_instance" "web" {
  # Establish connection to be used by all
  # Generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```