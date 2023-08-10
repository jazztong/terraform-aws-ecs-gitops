locals {
  projects            = yamldecode(file("configs/projects.yaml"))
  workspaces          = yamldecode(file("configs/workspaces.yaml"))
  workspace_variables = yamldecode(file("configs/workspace-variables.yaml"))
  flat_vars = flatten([
    for workspace, vars in local.workspace_variables : [
      for var in vars : merge(var, { workspace = workspace })
    ]
  ])
}
