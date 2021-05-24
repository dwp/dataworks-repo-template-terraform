
locals {
  name        = "dataworks-repo-template-terraform"
  environment = terraform.workspace == "default" ? "development" : terraform.workspace

  account = {
    {%- for key, value in accounts.items() %}
      {{key}} = "{{value}}"
    {%- endfor %}
  }

  persistence_tag_value = {
    development = "mon-fri,08:00-18:00"
    qa          = "Ignore"
    integration = "mon-fri,08:00-18:00"
    preprod     = "Ignore"
    production  = "Ignore"
  }

  auto_shutdown_tag_value = {
    development = "True"
    qa          = "False"
    integration = "True"
    preprod     = "False"
    production  = "False"
  }

  overridden_tags = {
    Role         = "repo_template_terraform"
    Owner        = "dataworks-repo-template-terraform"
    Persistence  = local.persistence_tag_value[local.environment]
    AutoShutdown = local.auto_shutdown_tag_value[local.environment]
  }

  common_repo_tags = "${merge(module.dataworks_common.common_tags, local.overridden_tags)}"

  cidr_block = {
  {%- for environment, ranges in cidr_block.items() %}
      {{ environment }} = {
        {%- for key, value in ranges.items() %}
          {{ key }} = "{{ value }}"{% endfor %}
      } {%- endfor %}
  }
}
