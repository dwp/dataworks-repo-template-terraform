# dataworks-repo-template-terraform
Template Terraform repository for DataWorks GitHub

This repo contains Makefile and base terraform folders and jinja2 files to fit the standard pattern.
This repo will be used as a base to create new repos, upon which the user runs make initial-commit, renaming the template files and adding the githooks submodule, making the repo ready for use.

### Initialisation steps
Welcome to your new DataWorks GitHub repository.

Please run:  
`make initial-commit`  and then `aviator`
to begin using your repository.  

The `initial-commit` will create a PR for you renaming all the templated content to be relevant for your repository. It will also add the `dataworks-githooks` submodule to the `.githooks` folder.  For more info see: [dataworks-githooks](https://github.com/dwp/dataworks-githooks)

Running aviator will create the pipeline required on the AWS-Concourse instance, in order pass a mandatory CI ran status check.  this will likely require you to login to Concourse, if you haven't already.

After these steps are ran, you can manipulate and change them to suit your needs.