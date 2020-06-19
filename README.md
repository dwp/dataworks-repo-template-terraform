# dataworks-repo-template-terraform

## Description

This repo contains Makefile and base terraform folders and jinja2 files to fit the standard pattern.
This repo is a base to create new Terraform repos, renaming the template files and adding the githooks submodule, making the repo ready for use.

Running aviator will create the pipeline required on the AWS-Concourse instance, in order pass a mandatory CI ran status check.  this will likely require you to login to Concourse, if you haven't already.


After cloning this repo please do the following: 

1. Configure Terraform:
    1. Update project name in `terraform.tf.j2` (see `locals` section)
    1. Set `assume_role` variable value in `variables.tf`
    1. Run:  
`make bootstrap`
    1. Create non-default Terraform workspaces as and if required:  
    `make terraform-workspace-new workspace=<workspace_name> `

1. Configure Concourse CI pipeline:
    1. Update project name in CI files - replace every instance of `dataworks-repo-template-terraform` with your project name under `./ci/`
    1. Add and/or remove jobs in `./ci/jobs` as required 
    1. Enable Terraform plan and apply tasks - update `./ci/meta.yml` as instructed in the comments inside `terraform-plan` and `terraform-apply` sections
    1. Create CI pipeline:  
`aviator`
