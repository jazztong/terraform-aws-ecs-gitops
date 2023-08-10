resource "tfe_project" "this" {
  for_each = local.projects

  name         = each.value.name
  organization = var.organization
}

resource "tfe_variable" "this" {
  for_each = { for var in local.flat_vars : "${var.workspace}.${var.key}" => var }

  key          = each.value.key
  value        = each.value.value
  category     = try(each.value.category, "terraform") == "terraform" ? "terraform" : "env"
  description  = try(each.value.description, null)
  hcl          = try(each.value.hcl, false) == true ? true : false
  sensitive    = try(each.value.sensitive, false) == true ? true : false
  workspace_id = tfe_workspace.this[each.value.workspace].id
}

resource "tfe_workspace" "this" {
  for_each = local.workspaces

  name         = each.key
  organization = var.organization

  allow_destroy_plan            = lookup(each.value, "allow_destroy_plan", true)
  assessments_enabled           = lookup(each.value, "assessments_enabled", false)
  auto_apply                    = lookup(each.value, "auto_apply", false)
  description                   = lookup(each.value, "description", "")
  execution_mode                = lookup(each.value, "execution_mode", "remote")
  file_triggers_enabled         = lookup(each.value, "file_triggers_enabled", true)
  force_delete                  = lookup(each.value, "force_delete", null)
  global_remote_state           = lookup(each.value, "global_remote_state", false)
  queue_all_runs                = lookup(each.value, "queue_all_runs", true)
  remote_state_consumer_ids     = lookup(each.value, "remote_state_consumer_ids", [])
  speculative_enabled           = lookup(each.value, "speculative_enabled", true)
  ssh_key_id                    = lookup(each.value, "ssh_key_id", null)
  structured_run_output_enabled = lookup(each.value, "structured_run_output_enabled", true)
  tag_names                     = lookup(each.value, "tag_names", [])
  terraform_version             = lookup(each.value, "terraform_version", null)
  trigger_patterns              = lookup(each.value, "trigger_patterns", null)
  trigger_prefixes              = lookup(each.value, "trigger_prefixes", null)
  working_directory             = lookup(each.value, "working_directory", null)
  project_id                    = try(tfe_project.this[lookup(each.value, "project_id", null)].id, null)

  dynamic "vcs_repo" {
    for_each = contains(keys(each.value), "vcs_repo") ? [each.value.vcs_repo] : []

    content {
      github_app_installation_id = var.github_install_id
      identifier                 = vcs_repo.value.identifier
      branch                     = lookup(vcs_repo.value, "branch", "master")
      ingress_submodules         = lookup(vcs_repo.value, "ingress_submodules", false)
      tags_regex                 = lookup(vcs_repo.value, "tags_regex", null)
    }
  }
}
