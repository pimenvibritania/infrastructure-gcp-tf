resource "google_project_iam_custom_role" "grit_provisioner_role" {
  role_id   = local.grit_role_id
  title     = "GRIT Provisioner Role"
  project = local.project
  description = "A role with minimum list of permissions required for GRIT provisioning"
  permissions = [
    "cloudkms.cryptoKeyVersions.destroy",
    "cloudkms.cryptoKeyVersions.list",
    "cloudkms.cryptoKeyVersions.useToEncrypt",
    "cloudkms.cryptoKeys.create",
    "cloudkms.cryptoKeys.get",
    "cloudkms.cryptoKeys.update",
    "cloudkms.keyRings.create",
    "cloudkms.keyRings.get",
    "compute.disks.create",
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.instanceGroupManagers.create",
    "compute.instanceGroupManagers.delete",
    "compute.instanceGroupManagers.get",
    "compute.instanceGroups.create",
    "compute.instanceGroups.delete",
    "compute.instanceTemplates.create",
    "compute.instanceTemplates.delete",
    "compute.instanceTemplates.get",
    "compute.instanceTemplates.useReadOnly",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
    "compute.instances.setLabels",
    "compute.instances.setMetadata",
    "compute.instances.setServiceAccount",
    "compute.instances.setTags",
    "compute.networks.create",
    "compute.networks.delete",
    "compute.networks.get",
    "compute.networks.updatePolicy",
    "compute.subnetworks.create",
    "compute.subnetworks.delete",
    "compute.subnetworks.get",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zones.get",
    "iam.roles.create",
    "iam.roles.delete",
    "iam.roles.get",
    "iam.roles.list",
    "iam.roles.update",
    "iam.serviceAccounts.actAs",
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy",
    "storage.buckets.create",
    "storage.buckets.delete",
    "storage.buckets.get",
    "storage.buckets.getIamPolicy",
    "storage.buckets.setIamPolicy"
  ]
  stage = "BETA"
}

# Create the service account
resource "google_service_account" "grit_provisioner_sa" {
  account_id   = local.grit_sa
  display_name = "GRIT Provisioner"
  description  = "Service account for GRIT provisioning"
  project = local.project
}

resource "google_project_iam_binding" "grit_provisioner_binding" {
  project = local.project
  role    = "projects/${local.project}/roles/${local.grit_role_id}"
  members = [
    "serviceAccount:${google_service_account.grit_provisioner_sa.email}"
  ]
}
