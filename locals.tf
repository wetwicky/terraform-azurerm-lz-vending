locals {
  # subscription_id_alias is the id of the newly created subscription, if it exists.
  subscription_id_alias = can(azapi_resource.subscription_alias[0].output) ? jsondecode(azapi_resource.subscription_alias[0].output).properties.subscriptionId : null

  # subscription_id is the id of the subscription into which resources will be created.
  # We pick the created sub id first, if it exists, otherwise we pick the subscription_id variable.
  # If this is blank then something has gone wrong.
  subscription_id = can(coalesce(local.subscription_id_alias, var.subscription_id)) ? coalesce(local.subscription_id_alias, var.subscription_id) : ""

  # management_group_resource_id_prefix is the prefix of the management group resource id.
  subscription_alias_management_group_resource_id = "/providers/Microsoft.Management/managementGroups/${var.subscription_alias_management_group_id}"
}
