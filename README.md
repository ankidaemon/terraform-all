# terraform-all
terraform all with aws

Iterative examples to setup aws using terraform. 

Each folder ( not module ) will have all resources setup in previous folder.

**How to run?**


cd any-folder

terraform init

terraform validate

terraform plan -var-file=../secret.tfvars

terraform apply -var-file=../secret.tfvars

terraform destroy -var-file=../secret.tfvars
